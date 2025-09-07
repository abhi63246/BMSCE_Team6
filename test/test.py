# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_mod6_counter(dut):
    dut._log.info("Starting Mod-6 counter test")

    # Create 10 MHz clock (100 ns period)
    clock = Clock(dut.clk, 100, units="ns")
    cocotb.start_soon(clock.start())

    # Apply reset
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1

    dut._log.info("Testing counting behavior")

    # Expected sequence for a mod-6 counter
    expected_sequence = [0, 1, 2, 3, 4, 5, 0, 1, 2, 3]

    for i, expected in enumerate(expected_sequence):
        await ClockCycles(dut.clk, 1)
        actual = dut.uo_out.value.integer & 0b111  # lower 3 bits
        dut._log.info(f"Cycle {i}: uo_out = {actual}, expected = {expected}")
        assert actual == expected, f"Cycle {i}: Expected {expected}, got {actual}"
