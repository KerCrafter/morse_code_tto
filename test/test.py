import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_letter_E(dut):
    """Test case for letter 'E' (dot followed by char space)."""
    dut._log.info("=== Testing letter E ===")

    # Start clock (10 us period)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 5)

    # Step 1: Apply DOT pulse for multiple cycles (ui_in[0])
    dut.ui_in.value = 0b00000001  # dot_inp = 1
    await ClockCycles(dut.clk, 3)
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 5)

    # Step 2: Apply CHARACTER SPACE pulse for multiple cycles (ui_in[2])
    dut.ui_in.value = 0b00000100  # char_space_inp = 1
    await ClockCycles(dut.clk, 5)  # allow several cycles for FSM to register
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 10)

    # Step 3: Observe output
    observed = int(dut.uo_out.value)
    dut._log.info(f"Observed output = 0x{observed:02X}")
    expected = 0x86  # for 'E'

    assert observed == expected, f"Expected 0x{expected:02X}, got 0x{observed:02X}"
