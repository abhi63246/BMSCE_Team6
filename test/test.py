# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Clock at 100 kHz (10 us period)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Apply reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)  # sync after releasing reset

    dut._log.info("Test project behavior")

    # Expected sequence: RTL increments before driving uo_out,
    # so the first observed value is 1 (not 0)
    expected_sequence = [1, 2, 3, 4, 5, 0, 1, 2]

    for i, expected in enumerate(expected_sequence):
        await ClockCycles(dut.clk, 1)
        actual = int(dut.uo_out.value) & 0b111  # Only use lower 3 bits
        dut._log.info(f"Cycle {i}: uo_out = {actual}, expected = {expected}")
        assert actual == expected, f"Cycle {i}: Expected {expected}, got {actual}"
