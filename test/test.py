# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

# --- Configuration ---
# NOTE: Input masks (DOT_MASK, CHAR_SPACE_MASK) are no longer used as the design
# now uses dedicated signals (dot_inp, char_space_inp, etc.).
CODE_E = 0x65           # The output code for 'e'
CODE_NO_OUTPUT = 0xFF   # Default output when decoding is in progress or FSM is reset

# --- Helper Function (Updated for dedicated input signals) ---

async def send_pulse(dut, signal):
    """
    Sets the given input signal (e.g., dut.dot_inp) high for exactly one clock cycle,
    then sets it back to zero.
    """
    # 1. Set signal high on the rising edge of the clock
    signal.value = 1
    await RisingEdge(dut.clk)
    
    # 2. Set signal low on the next rising edge of the clock
    signal.value = 0
    await RisingEdge(dut.clk) # Wait one extra cycle to ensure timing stability
    
@cocotb.test()
async def test_decode_e(dut):
    dut._log.info("Starting Morse Decoder Test for 'E' using new dedicated input signals (dot_inp, char_space_inp).")

    # Set the clock period. Using (value, units) positional arguments for compatibility.
    clock = Clock(dut.clk, 10, "us")
    cocotb.start_soon(clock.start())

    # --- Initialize Inputs ---
    dut.ena.value = 1
    # Initialize all new dedicated input signals to 0
    dut.dot_inp.value = 0
    dut.dash_inp.value = 0
    dut.char_space_inp.value = 0
    dut.word_space_inp.value = 0
    
    # The original inputs (ui_in, uio_in) are likely unused now but setting them just in case
    # If your top module doesn't have these ports, you may need to comment these lines out.
    # dut.ui_in.value = 0
    # dut.uio_in.value = 0

    # --- Apply Reset (Now using active-HIGH 'rst') ---
    dut.rst.value = 1 # Active High Reset
    await ClockCycles(dut.clk, 10)
    dut.rst.value = 0 # End Reset
    await RisingEdge(dut.clk)
    dut._log.info("Reset complete (rst transitioned 1 -> 0).")

    # Wait one cycle for the receiver FSM to settle into 0xFF
    await ClockCycles(dut.clk, 1)
    # Check new output signal name 'sout'
    assert dut.sout.value.integer == CODE_NO_OUTPUT, f"Output sout should be {hex(CODE_NO_OUTPUT)} after reset."

    # --- TEST: Decode 'E' (.) ---
    dut._log.info("--- Test: Decoding 'E' (.) ---")

    # 1. Send DOT pulse on the dedicated dot_inp wire
    dut._log.info("Sending DOT pulse on dot_inp...")
    await send_pulse(dut, dut.dot_inp)
    
    # Check intermediate state: output should still be 0xFF after the dot pulse.
    assert dut.sout.value.integer == CODE_NO_OUTPUT, "Output should still be 0xFF after the dot pulse."

    # 2. Send Character Space pulse on the dedicated char_space_inp wire (triggers the output)
    dut._log.info("Sending CHAR_SPACE pulse on char_space_inp to complete the character...")
    await send_pulse(dut, dut.char_space_inp)

    # Wait one cycle after the CHAR_SPACE pulse finishes.
    await ClockCycles(dut.clk, 1) 
    
    # Cycle 1 (after char space pulse ends): The output should register the decoded value.
    assert dut.sout.value.integer == CODE_E, f"Failed to decode 'E'. Expected {hex(CODE_E)}, Got {hex(dut.sout.value.integer)}"

    # Cycle 2: The output should return to 0xFF.
    await ClockCycles(dut.clk, 1)
    assert dut.sout.value.integer == CODE_NO_OUTPUT, f"Output should return to {hex(CODE_NO_OUTPUT)}."

    # Wait for FSM to completely settle
    await ClockCycles(dut.clk, 1)
    
    dut._log.info("Test for 'E' successfully passed using new design inputs.")
