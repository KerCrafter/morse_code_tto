# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

# --- Configuration ---
# Input Masks (mapped to ui_in[3:0])
DOT_MASK = 0x01         # ui_in[0]
CHAR_SPACE_MASK = 0x04  # ui_in[2]

# Output Codes (from rec_fsm.v)
CODE_E = 0x86           # The output code for 'e'
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
    await RisingEdge(dut.clk) # Wait one extra cycle
    
@cocotb.test()
async def test_decode_e(dut):
    dut._log.info("Starting Morse Decoder Test for 'E'")

    # Set the clock period
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Apply Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    await RisingEdge(dut.clk)
    dut._log.info("Reset complete.")

    # Wait one cycle for the receiver FSM to settle into 0xFF
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, f"Output should be {hex(CODE_NO_OUTPUT)} after reset."

    # --- TEST: Decode 'E' (.) ---
    dut._log.info("--- Test: Decoding 'E' (.) ---")

    # 1. Send DOT pulse (moves rec_fsm to state 'e')
    await send_pulse(dut, DOT_MASK)
    # At this point, rec_fsm is in state 'e' (8'h04), uo_out remains 0xFF.
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, "Output should still be 0xFF after the dot pulse."

    # 2. Send Character Space pulse (triggers the output)
    # The trans_fsm takes CHAR_SPACE_MASK high for 1 cycle and then
    # internally sequences 3 cycles of 3'b011 to rec_fsm.
    await send_pulse(dut, CHAR_SPACE_MASK)

    # Cycle 2: The output is registered. uo_out should be 0x86.
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value.integer == CODE_E, f"Failed to decode 'E'. Expected {hex(CODE_E)}, Got {hex(dut.uo_out.value.integer)}"

    # Cycle 3: The FSM resets the output.
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, f"Output should return to {hex(CODE_NO_OUTPUT)}."

    # Wait for the last cycle of the char space sequence
    await ClockCycles(dut.clk, 1)
    
    dut._log.info("Test for 'E' successfully passed.")
