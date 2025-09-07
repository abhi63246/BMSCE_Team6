# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_mod6_counter(dut):
    dut._log.info("Starting Mod-6 counter test")

    # Start the clock: 10 us period (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Initialize signals
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    # Hold reset for 10 clock cycles
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Testing counting behavior")

    # Expected sequence for Mod-6 counter: 0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 0 -> 1 ...
    expected_sequence = [0, 1, 2, 3, 4, 5, 0, 1]

    for i, expected in enumerate(expected_sequence):
        await ClockCycles(dut.clk, 1)
        actual = dut.uo_out.value.integer & 0b111  # Only lower 3 bits are counter
        dut._log.info(f"Cycle {i}: uo_out = {actual}, expected = {expected}")
        assert actual == expected, f"Cycle {i}: Expected {expected}, got {actual}"
