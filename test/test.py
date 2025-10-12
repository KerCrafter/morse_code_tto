import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_letter_E(dut):
    """Test case for letter 'E' (dot followed by char space)."""
    dut._log.info("=== Testing letter E ===")

    # Start clock (10us period)
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

    # Step 1: Apply one DOT pulse
    # ui_in[0] = dot_inp
    dut.ui_in.value = 0b00000001  # dot_inp=1
    await ClockCycles(dut.clk, 1)

    # Release input
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 2)

    # Step 2: Apply character space pulse
    dut.ui_in.value = 0b00000100  # char_space_inp=1
    await ClockCycles(dut.clk, 3)  # allow 3 cycles as per FSM
    dut.ui_in.value = 0

    # Step 3: Wait a few cycles for output to settle
    await ClockCycles(dut.clk, 3)

    # Check output
    observed = int(dut.uo_out.value)
    dut._log.info(f"Observed output = 0x{observed:02X}")
    expected = 0x86  # from rec_fsm for letter 'E'

    assert observed == expected, f"Expected 0x{expected:02X}, got 0x{observed:02X}"
