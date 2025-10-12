import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_letter_E(dut):
    """Test case for Morse letter 'E' (dot followed by char space)."""
    dut._log.info("=== Testing letter E ===")

    # --- Clock setup ---
    clock = Clock(dut.clk, 10, units="us")  # 10us period = 100kHz
    cocotb.start_soon(clock.start())

    # --- Initial setup ---
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    dut._log.info("Applying reset (active low)")
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    dut._log.info("Reset released")
    await ClockCycles(dut.clk, 10)

    # --- Step 1: Send DOT (ui_in[0]) ---
    dut._log.info("Applying DOT input (ui_in[0])")
    dut.ui_in.value = 0b00000001  # dot_inp = 1
    await ClockCycles(dut.clk, 3)
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 5)

    # --- Step 2: Send CHAR SPACE (ui_in[2]) ---
    dut._log.info("Applying CHAR SPACE input (ui_in[2])")
    dut.ui_in.value = 0b00000100  # char_space_inp = 1
    await ClockCycles(dut.clk, 5)
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 10)

    # --- Step 3: Observe outputs ---
    observed = int(dut.uo_out.value)
    dut._log.info(f"Observed uo_out = 0x{observed:02X}")

    # Debug: print key signals for traceability
    dot_inp = int(dut.ui_in.value & 1)
    dash_inp = (int(dut.ui_in.value) >> 1) & 1
    char_space_inp = (int(dut.ui_in.value) >> 2) & 1
    rst_n = int(dut.rst_n.value)
    ena = int(dut.ena.value)

    dut._log.info(f"DEBUG: dot_inp={dot_inp} dash_inp={dash_inp} "
                  f"char_space_inp={char_space_inp} rst_n={rst_n} ena={ena}")

    expected = 0x86  # for letter E
    assert observed == expected, f"Expected 0x{expected:02X}, got 0x{observed:02X}"
