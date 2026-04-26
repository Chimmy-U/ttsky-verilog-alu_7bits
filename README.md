![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# Tiny Tapeout Verilog 7-bit ALU

7-bit ALU with serial input and parallel output. Designed for [Tiny Tapeout](https://tinytapeout.com) SKY130.

Project proposed in the *Chip Design and Fabrication Bootcamp*, developed at the Technological University of Pereira.

## Documentation

[Read the project documentation.](docs/info.md) It covers:
- Project description  
- How does it work?  
- How to test it?  

## Tiny Tapeout Details

| Property | Value |
|---|---|
| Top module | `tt_um_alu_7bits` |
| Tiles | 1x1 |
| Clock | 50 MHz (20 ns period) |
| Process | SKY130 |
| Language | Verilog |

## Pinout

### Inputs (`ui_in`)

| Pin | Function |
|---|---|
| `ui_in[0]` | BIT_IN (Serial data input) |
| `ui_in[3:1]` | OP (Operation select) |
| `ui_in[7:4]` | Unused |

### Outputs (`uo_out`)

| Pin | Function |
|---|---|
| `uo_out[6:0]` | DATA_OUT (Parallel data output, LSB) |
| `uo_out[7]` | DONE (Indicates operation complete and valid output) |

## What is Tiny Tapeout?

Tiny Tapeout is an educational project aimed at making it easier and more affordable than ever to manufacture your digital and analog designs on a real chip.

To learn more and get started, visit https://tinytapeout.com.

## Resources

- [FAQ](https://tinytapeout.com/faq/)
- [Digital design lessons](https://tinytapeout.com/digital_design/)
- [Learn how semiconductors work](https://tinytapeout.com/siliwiz/)
- [Join the community](https://tinytapeout.com/discord)
- [Build your design locally](https://www.tinytapeout.com/guides/local-hardening/)

### Social Media

- LinkedIn [#tinytapeout](https://www.linkedin.com/search/results/content/?keywords=%23tinytapeout) [@TinyTapeout](https://www.linkedin.com/company/100708654/)
- Mastodon [#tinytapeout](https://chaos.social/tags/tinytapeout) [@matthewvenn](https://chaos.social/@matthewvenn)
- X (formerly Twitter) [#tinytapeout](https://twitter.com/hashtag/tinytapeout) [@tinytapeout](https://twitter.com/tinytapeout)
- Bluesky [@tinytapeout.com](https://bsky.app/profile/tinytapeout.com)
