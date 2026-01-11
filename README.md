# fpga_vivado_tcl_template
This repository is a template for vivado projects using tcl  
=======
Vivado TCL Template
Overview

This repository provides a **reproducible, version-controlled workflow** for creating and managing AMD/Xilinx Vivado FPGA projects using **TCL scripts**.


Instead of relying on GUI-generated project files, all project creation, configuration, and build steps are driven through TCL scripts and version-controlled text files. This approach improves portability, reviewability, and long-term maintainability.

The goal of this template is to:
- Separate **source-of-truth design files** from tool-generated artifacts
- Enable **clean Git version control** for FPGA projects
- Allow Vivado projects to be **fully regenerated from scripts**
- Support both **batch (CI-style)** and **GUI-based** development

Repository Structure
vivado-tcl-template/
├── rtl/            # HDL source files (Verilog / SystemVerilog / VHDL)
├── constraints/    # XDC timing and pin constraints
├── scripts/        # Vivado TCL scripts (project creation, build, synth, impl)
├── docs/           # Documentation and design notes
├── README.md       # Project overview and usage instructions
└── .gitignore      # Excludes Vivado-generated artifacts

Directory Intent
### Tracked in Git
- RTL (`rtl/`)
- Testbenches (`tb/`)
- Constraints (`constraints/`)
- TCL scripts (`scripts/`)
- Documentation (`docs/`)

### Ignored by Git
- Vivado projects (`.xpr`)
- Build outputs (`.runs`, `.cache`, `.Xil`, bitstreams)
- Simulation databases

Documents
- Design rationale, block diagrams, notes, and assumptions.
- Design Philosophy

No Vivado GUI files are committed
Generated outputs are disposable

If the repository is cloned on a new machine, the project should be rebuildable without manual GUI interaction for version control
