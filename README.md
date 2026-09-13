# 4-Bit FIR Filter (Verilog RTL & Cadence Innovus Implementation)

A 4-tap, 4-bit Finite Impulse Response (FIR) Filter implemented in Verilog RTL, fully simulated and implemented using Cadence Innovus / ASIC Physical Design flow.

---

## 📌 Features & Specifications
- **Architecture**: 4-Tap Transversal Direct Form FIR Filter
- **Input Data Width ($x$)**: 4-bit
- **Filter Coefficients ($h_0, h_1, h_2, h_3$)**: 4-bit programmable/configurable inputs
- **Output Data Width ($y$)**: 10-bit output to prevent overflow:
  $$\text{Max Output} = 4 \times (15 \times 15) = 900 \le 1023 \, (2^{10} - 1)$$
- **Clock & Reset**: Active-high synchronous reset (`rst`) and single-phase clock (`clk`).

---

## 📐 Filter Equation

$$y[n] = h_0 \cdot x[n] + h_1 \cdot x[n-1] + h_2 \cdot x[n-2] + h_3 \cdot x[n-3]$$

---

## 📁 Repository Structure

```
.
├── rtl/
│   └── fir.v                      # Top-level 4-Bit FIR Filter Verilog RTL Module
├── verification/
│   └── fir_tb.v                   # Testbench module for functional verification
├── simulation/
│   ├── fir.vcd                    # VCD waveform dump file
│   └── waveform.png               # Simulation waveform output graph
├── synthesis/
│   ├── fir_synth.v                # Synthesized Netlist Module
│   └── schematic/
│       ├── fir_schematic.svg      # RTL Schematic Diagram (SVG Vector)
│       └── fir_schematic.dot      # Graphviz DOT file for schematic
├── physical_design/
│   ├── innovus/
│   │   ├── innovus.png            # Cadence Innovus physical design layout result
│   │   └── run_innovus.tcl        # Cadence Innovus automation script
│   └── librelane/                 # Open-Source ASIC Physical Design outputs
└── README.md                      # Project documentation
```

---

## 🎨 RTL Schematic Diagram

![RTL Schematic](synthesis/schematic/fir_schematic.svg)


---

## 🌊 Waveform & Simulation Output

### Waveform Result (`simulation/waveform.png`):
![Simulation Waveform](simulation/waveform.png)

### Expected Output Sequence:

| Time (ns) | Reset | $x$ | $x_0$ | $x_1$ | $x_2$ | $x_3$ | Calculated Output $y$ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **0 - 100** | `1` | `0` | `0` | `0` | `0` | `0` | **0** |
| **100 - 125** | `0` | `1` | `0` | `0` | `0` | `0` | **0** |
| **125 - 225** | `0` | `2` | `1` | `0` | `0` | `0` | **1** $(1 \times 1)$ |
| **225 - 325** | `0` | `3` | `2` | `1` | `0` | `0` | **4** $(1 \times 2 + 2 \times 1)$ |
| **325 - 425** | `0` | `4` | `3` | `2` | `1` | `0` | **9** $(1 \times 3 + 2 \times 2 + 2 \times 1)$ |
| **425 - 625** | `0` | `4` | `4` | `3` | `2` | `1` | **19** $(1 \times 4 + 2 \times 3 + 2 \times 2 + 1 \times 1)$ |

---

## 🛠 Cadence Innovus ASIC Physical Design

### Physical Design Layout (`physical_design/innovus/innovus.png`):
![Cadence Innovus Layout](physical_design/innovus/innovus.png)

The physical design flow was executed using **Cadence Innovus Implementation System**:

1. **Synthesis / Import**: Netlist import and gate-level synthesis binding.
2. **Floorplanning & Power Planning**: Core aspect ratio configuration, power ring and stripe generation ($VDD$ / $VSS$).
3. **Placement**: Standard cell placement with setup/hold timing constraints.
4. **Clock Tree Synthesis (CTS)**: Low-skew clock tree insertion.
5. **Routing**: NanoRoute global & detail routing.
6. **Signoff (DRC/LVS & STA)**: Static timing analysis and layout verification.

---

## 🚀 How to Run Simulation

Using **Icarus Verilog** or any standard IEEE 1364 simulator:

```bash
# Compile design and testbench
iverilog -o simulation/fir_sim rtl/fir.v verification/fir_tb.v

# Run simulation
vvp simulation/fir_sim
```

---

## 📜 License
This project is open-source under the MIT License.
