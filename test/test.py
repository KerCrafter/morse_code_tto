# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def morse_code_single_char_test(dut):
    """Test Morse code transmitter for single character: dot dot dot + char_space (active-low reset)"""

    dut._log.info("Starting single character Morse code test with active-low reset")

    # Start clock (10 ns period)
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Apply active-low reset
    dut.rst_n.value = 0   # Assert reset (active-low)
    dut.dot_inp.value = 0
    dut.dash_inp.value = 0
    dut.char_space_inp.value = 0
    dut.word_space_inp.value = 0
    await ClockCycles(dut.clk, 5)

    dut.rst_n.value = 1   # Deassert reset
    await ClockCycles(dut.clk, 5)
    dut._log.info("Reset deasserted (rst_n=1)")

    # Helper: 1 cycle high, 1 cycle low
    async def single_cycle_pulse(signal):
        signal.value = 1
        await ClockCycles(dut.clk, 1)
        signal.value = 0
        await ClockCycles(dut.clk, 1)
        dut._log.info(f"Pulsed {signal._name} for 1 cycle")

    # -------------------------
    # Input sequence: dot dot dot + char_space
    # -------------------------
    await single_cycle_pulse(dut.dot_inp)
    await single_cycle_pulse(dut.dot_inp)
    await single_cycle_pulse(dut.dot_inp)
    await single_cycle_pulse(dut.char_space_inp)

    # Allow FSM to settle and update sout
    await ClockCycles(dut.clk, 5)

    # Check sout value
    sout_val = dut.sout.value.integer
    dut._log.info(f"sout observed value = 0x{sout_val:02X}")

    expected_val = 0x92
    assert sout_val == expected_val, f"Expected sout=0x{expected_val:02X}, got 0x{sout_val:02X}"

    dut._log.info("Single character Morse code test passed")
