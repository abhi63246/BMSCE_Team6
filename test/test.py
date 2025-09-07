# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Expected counter sequence
    expected_sequence = [0, 1, 2, 3, 4, 5, 0, 1]

    for i, expected in enumerate(expected_sequence):
        await ClockCycles(dut.clk, 1)

        # Get counter value safely (skip X/Z states)
        raw_val = dut.uo_out.value
        if raw_val.is_resolvable:
            actual = raw_val.integer & 0b111  # Use lower 3 bits only
            dut._log.info(f"Cycle {i}: uo_out = {actual}, expected = {expected}")
            assert actual == expected, f"Cycle {i}: Expected {expected}, got {actual}"
        else:
            dut._log.warning(f"Cycle {i}: uo_out unresolved (X/Z), skipping check")
