# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_mod6_counter(dut):
    dut._log.info("Starting Mod-6 counter test")

    # Clock: 10us period
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)   # hold reset 5 cycles
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)   # wait 1 cycle for counter to start

    # Test counter for 2 full cycles (0-5)
    expected_sequence = [0,1,2,3,4,5,0,1,2,3,4,5]
    for i, expected in enumerate(expected_sequence):
        actual = dut.uo_out.value.integer
        dut._log.info(f"Cycle {i}: uo_out = {actual}, expected = {expected}")
        assert actual == expected, f"Cycle {i}: Expected {expected}, got {actual}"
        await ClockCycles(dut.clk, 1)
