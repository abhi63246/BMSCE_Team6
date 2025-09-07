![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# Mod-6 Counter - Tiny Tapeout Verilog Project

- [Read the documentation for project](docs/info.md)

## What is Tiny Tapeout?

Tiny Tapeout is an educational project that makes it easier and cheaper to get your digital and analog designs manufactured on a real chip.

To learn more and get started, visit https://tinytapeout.com.

## Design Name

**Mod-6 Counter**  
A 3-bit synchronous counter that counts from 0 to 5 and wraps back to 0.

## How it works

- The counter increments on each rising edge of the clock (`clk`).  
- When the counter reaches 5, it wraps around to 0 (modulo-6).  
- The current counter value is output on `uo_out[2:0]`; higher bits (`uo_out[7:3]`) are tied to 0.  
- `rst_n` is an active-low asynchronous reset. When asserted low, the counter immediately resets to 0.  
- IO outputs `uio_out` and `uio_oe` are tied to 0 since no bidirectional functionality is used.  

## Block Diagram

+----------------------+
        |                            |
clk     | ---> [ Mod-6 Counter ] --->| uo_out[2:0]
rst_n   |                            |
+----------------------+

## Waveform

Below is an example of the expected counter output over time:

Clock: ──┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐
Count: 0 1 2 3 4 5 0 1 ...

- The counter increments on every rising clock edge.  
- After reaching 5, it wraps around to 0.

## I/Os

| Pin      | Direction | Description                 |
|----------|-----------|-----------------------------|
| ui[0:7]  | Input     | Unused                       |
| uo[0]    | Output    | Counter Bit 0 (LSB)          |
| uo[1]    | Output    | Counter Bit 1                |
| uo[2]    | Output    | Counter Bit 2 (MSB)          |
| uo[3:7]  | Output    | Unused                       |
| uio[0:7] | Bidirectional | Unused                  |

## How to test

1. **Cocotb simulation**:  
   - Run `test/test_project.py`.  
   - Observe `uo_out[2:0]` waveform in GTKWave.  
   - Counter should increment 0 → 1 → 2 → 3 → 4 → 5 and wrap to 0.

2. **Verilog simulation**:  
   - Run `tb.v`.  
   - VCD file `tb.vcd` will be generated for waveform viewing.

## External hardware

No external hardware is required; this project runs purely on-chip in the Tiny Tapeout framework.

## Set up your Verilog project

1. Add your Verilog files to the `src` folder.  
2. Edit the [info.yaml](info.yaml) and update your project info.  
3. Edit [docs/info.md](docs/info.md) for project description.  
4. Adapt the testbench to your design if needed.

The GitHub action automatically builds the ASIC files using [OpenLane](https://www.zerotoasiccourse.com/terminology/openlane/).

## Enable GitHub actions to build the results page

- [Enabling GitHub Pages](https://tinytapeout.com/faq/#my-github-action-is-failing-on-the-pages-part)

## Resources

- [FAQ](https://tinytapeout.com/faq/)  
- [Digital design lessons](https://tinytapeout.com/digital_design/)  
- [Learn how semiconductors work](https://tinytapeout.com/siliwiz/)  
- [Join the community](https://tinytapeout.com/discord)  
- [Build your design locally](https://www.tinytapeout.com/guides/local-hardening/)

## What next?

- [Submit your design to the next shuttle](https://app.tinytapeout.com/).  
- Share your project on social media:  
  - LinkedIn [#tinytapeout](https://www.linkedin.com/search/results/content/?keywords=%23tinytapeout) [@TinyTapeout](https://www.linkedin.com/company/100708654/)  
  - Mastodon [#tinytapeout](https://chaos.social/tags/tinytapeout) [@matthewvenn](https://chaos.social/@matthewvenn)  
  - X (formerly Twitter) [#tinytapeout](https://twitter.com/hashtag/tinytapeout) [@tinytapeout](https://twitter.com/tinytapeout)
