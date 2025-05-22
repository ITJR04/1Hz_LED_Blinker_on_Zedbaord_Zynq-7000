# 🔴 1Hz LED Blinker on ZedBoard Zynq-7000

This project implements a simple 1Hz LED blinker in VHDL on the ZedBoard Zynq-7000. It uses a 100 MHz clock input to toggle **LD0 (pin T22)** once every second using an **enable-based counter** design (not a direct clock divider). This project is beginner friendly for FPGA as it only uses the PL(Programmable logic) of the Zedboard.

---

## 📦 Project Details

- **Top Module:** `Zedboard_1HZ_LED_blink`
- **Clock Input:** 100 MHz onboard oscillator
- **Output:** Blinks **LD0** at 1Hz (1 blink/sec)
- **Reset Pin:** **SW5 (H18)** — active-high synchronous reset
- **Design Goal:** Demonstrate using a counter and enable signal to implement accurate 1Hz blinking without clock division

---

## 🛠️ Tools Used

- **Vivado Design Suite** (e.g., Vivado 2023.x)
- **VHDL** for hardware description
- **Optional:** GHDL/GTKWave for simulation and waveform viewing

---
## 📐 How the Design Works

The design uses a 100 MHz system clock and a 50 million count to toggle the LED once per second. Instead of dividing the clock signal, it generates an **enable pulse every 1 second** using a counter. When the enable signal is active, the LED state toggles.

### ➕ Reset

If **SW5 (H18)** is pressed:
- The counter resets
- The LED state is reset to OFF

---

## 🔌 Vivado Build & Program Steps

1. **Open Project in Vivado**
   - Launch Vivado
   - Open the `.xpr` file inside the `vivado_project/` folder

2. **Run Synthesis & Implementation**
   - Click *Run Synthesis*
   - Click *Run Implementation*
   - Check timing summary

3. **Generate Bitstream**
   - Click *Generate Bitstream*

4. **Program the FPGA**
   - Connect your ZedBoard via JTAG
   - Go to *Open Hardware Manager* → *Open Target* → *Auto Connect*
   - Click *Program Device* and select the `.bit` file

5. **Observe Output**
   - **LD0 (T22)** will blink ON/OFF once per second
   - Press **SW5 (H18)** to reset the blinker

---

## 📄 Pin Constraints (zedboard_1Hz.xdc)

```xdc
set_property PACKAGE_PIN T22 [get_ports LED]
set_property IOSTANDARD LVCMOS33 [get_ports LED]

set_property PACKAGE_PIN H18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

set_property PACKAGE_PIN E15 [get_ports clk]  # 100 MHz input clock
set_property IOSTANDARD LVCMOS33 [get_ports clk]
