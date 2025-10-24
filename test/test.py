# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

# --- Configuration ---
# Input Masks (mapped to ui_in[7:0] for morse_top instance inside tt_um_morse)
DOT_MASK = 0x01         # ui_in[0] -> dot_inp
CHAR_SPACE_MASK = 0x04  # ui_in[2] -> char_space_inp
DASH_MASK = 0x02        # ui_in[1] -> dash_inp (Not used in this test)

# Output Codes (assuming the output code for 'e' is 0x65 from previous context)
CODE_E = 0x65           # The expected output code for 'e'
CODE_NO_OUTPUT = 0xFF   # Default output when decoding is in progress or FSM is reset

# --- Helper Function ---

async def send_pulse(dut, mask):
    """
    Sets the input 'ui_in' high based on the mask for exactly one clock cycle,
    then sets it back to zero.
    """
    dut.ui_in.value = mask
    await RisingEdge(dut.clk)
    dut.ui_in.value = 0
    await RisingEdge(dut.clk) # Wait one extra cycle to ensure timing stability
    
@cocotb.test()
async def test_decode_e(dut):
    dut._log.info("Starting Morse Decoder Test for 'E' using ui_in masks.")

    # Set the clock period (using positional arguments for maximum compatibility)
    clock = Clock(dut.clk, 10, "us")
    cocotb.start_soon(clock.start())

    # --- Initialize Inputs ---
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    
    # --- Apply Reset (Active-LOW 'rst_n') ---
    dut.rst_n.value = 0 # Active Low Reset
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1 # End Reset
    await RisingEdge(dut.clk)
    dut._log.info("Reset complete (rst_n transitioned 0 -> 1).")

    # Wait one cycle for the receiver FSM to settle into 0xFF
    await ClockCycles(dut.clk, 1)
    # Check the standard output signal name 'uo_out'
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, f"Output uo_out should be {hex(CODE_NO_OUTPUT)} after reset."

    # --- TEST: Decode 'E' (.) ---
    dut._log.info("--- Test: Decoding 'E' (.) ---")

    # 1. Send DOT pulse (ui_in[0] = 1)
    dut._log.info("Sending DOT pulse (mask 0x01) on ui_in...")
    await send_pulse(dut, DOT_MASK)
    
    # Check intermediate state: output should still be 0xFF after the dot pulse.
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, "Output should still be 0xFF after the dot pulse."

    # 2. Send Character Space pulse (ui_in[2] = 1)
    dut._log.info("Sending CHAR_SPACE pulse (mask 0x04) on ui_in to complete the character...")
    await send_pulse(dut, CHAR_SPACE_MASK)

    # Wait one cycle after the CHAR_SPACE pulse finishes.
    await ClockCycles(dut.clk, 1) 
    
    # Cycle 1 (after char space pulse ends): The output should register the decoded value.
    assert dut.uo_out.value.integer == CODE_E, f"Failed to decode 'E'. Expected {hex(CODE_E)}, Got {hex(dut.uo_out.value.integer)}"

    # Cycle 2: The output should return to 0xFF.
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, f"Output should return to {hex(CODE_NO_OUTPUT)}."

    # Wait for FSM to completely settle
    await ClockCycles(dut.clk, 1)
    
    dut._log.info("Test for 'E' successfully passed using ui_in/uo_out interface.")
