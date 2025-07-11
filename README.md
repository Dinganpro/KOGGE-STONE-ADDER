# Kogge-Stone 4-bit Adder (Pipelined)

This repo implements a **4-bit Kogge-Stone Adder** in Verilog with pipelined inputs/outputs, and includes:

- D Flip-Flop for pipelining
- Kogge-Stone adder logic
- Exhaustive and functional testbench

## Files

- `kogge_stone_complete.v`: Core modules and logic
- `kogge_stone_top.v`: Top module with DFF-based pipelining
- `tb_kogge_stone_complete.v`: Full testbench with waveform dump and coverage
- `.gitignore`: Standard Verilog simulation ignores

## Simulation Instructions

### Using Icarus Verilog (CLI)

```bash
iverilog -o kogge kogge_stone_complete.v kogge_stone_top.v tb_kogge_stone_complete.v
vvp kogge
gtkwave kogge_stone_complete.vcd
