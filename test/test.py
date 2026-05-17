# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge


async def send_operands(dut, A, B, OP):
    # Reset
    dut.rst_n.value = 0
    dut.ui_in.value = 0

    # op está en ui_in[3:1]
    dut.ui_in.value = (OP << 1)

    await ClockCycles(dut.clk, 2)

    # Primer bit junto con salida de reset
    await FallingEdge(dut.clk)
    dut.rst_n.value = 1
    dut.ui_in.value = (OP << 1) | (A & 0x1)

    # Enviar A (LSB → MSB)
    for i in range(1, 7):
        await FallingEdge(dut.clk)
        bit = (A >> i) & 0x1
        dut.ui_in.value = (OP << 1) | bit

    # Enviar B (LSB → MSB)
    for i in range(7):
        await FallingEdge(dut.clk)
        bit = (B >> i) & 0x1
        dut.ui_in.value = (OP << 1) | bit

    # Línea en reposo
    await FallingEdge(dut.clk)
    dut.ui_in.value = (OP << 1)

    # Esperar EXECUTE + DONE
    await ClockCycles(dut.clk, 3)


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Clock a 50 MHz
    clock = Clock(dut.clk, 20, unit="ns")
    cocotb.start_soon(clock.start())

    # Reset inicial
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1

    # =========================
    # PRUEBA 1: SUMA
    # 25 + 12 = 37
    # =========================
    dut._log.info("Test SUMA")

    await send_operands(dut, 25, 12, 0b000)

    result = dut.uo_out.value.integer & 0x7F
    done   = (dut.uo_out.value.integer >> 7) & 0x1

    dut._log.info(f"Resultado SUMA: {result}")

    assert result == 37, f"SUMA incorrecta: {result}"
    assert done == 1, "Done no activado en SUMA"

    # =========================
    # PRUEBA 2: AND
    # 85 & 102 = 68
    # =========================
    dut._log.info("Test AND")

    await send_operands(dut, 85, 102, 0b001)

    result = dut.uo_out.value.integer & 0x7F
    done   = (dut.uo_out.value.integer >> 7) & 0x1

    dut._log.info(f"Resultado AND: {result}")

    assert result == 68, f"AND incorrecto: {result}"
    assert done == 1, "Done no activado en AND"
