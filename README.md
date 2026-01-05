<<<<<<< HEAD
# fpga_vivado_tcl_template
This repository is a template and guideline for vivado projects using tcl  
=======
Vivado TCL Template
Overview

This repository provides a clean, reproducible project template for working with Xilinx Vivado using TCL as the source of truth.

Instead of relying on GUI-generated project files, all project creation, configuration, and build steps are driven through TCL scripts and version-controlled text files. This approach improves portability, reviewability, and long-term maintainability.

Repository Structure
vivado-tcl-template/
├── rtl/            # HDL source files (Verilog / SystemVerilog / VHDL)
├── constraints/    # XDC timing and pin constraints
├── scripts/        # Vivado TCL scripts (project creation, build, synth, impl)
├── docs/           # Documentation and design notes
├── README.md       # Project overview and usage instructions
└── .gitignore      # Excludes Vivado-generated artifacts

Directory Intent

rtl/
Hand-written RTL only. No generated files.

constraints/
Explicit timing, clock, and pin constraints (.xdc).

scripts/
TCL scripts that:

Create the Vivado project

Add sources and constraints

Run synthesis and implementation

Generate bitstreams

docs/
Design rationale, block diagrams, notes, and assumptions.

Design Philosophy

TCL is the source of truth

No Vivado GUI files are committed

Generated outputs are disposable

Projects are reproducible from scratch

If the repository is cloned on a new machine, the project should be rebuildable without manual GUI interaction.
>>>>>>> baf7350 (Initial Vivado TCL-based project structure)
