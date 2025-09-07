import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer


@cocotb.test()
async def test_mod6_counter(dut):
    """Test the 3-bit Mod-6 synchronous counter"""

    dut._log.info("Starting Mod-6 counter test")

    # Start clock (10 ns period → 100 MHz, adjust as needed)
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    # Apply reset (active-low)
    dut.rst_n.value = 0
    dut.ena.value = 1  # keep enabled
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    await Timer(20, units="ns")   # hold reset for 2 cycles
    dut.rst_n.value = 1
    await RisingEdge(dut.clk)     # sync after release

    # Expected sequence for Mod-6 counter
    expected_seq = [0, 1, 2, 3, 4, 5]

    # Check multiple cycles
    for cycle in range(12):  # run two full wraps
        await RisingEdge(dut.clk)
        actual = int(dut.uo_out.value & 0b111)  # only bottom 3 bits
        expected = expected_seq[cycle % 6]

        dut._log.info(f"Cycle {cycle}: uo_out = {actual}, expected = {expected}")
        assert actual == expected, f"Cycle {cycle}: Expected {expected}, got {actual}"
