# ==========================================
# Vivado Project Creation Script (Prompted)
# ==========================================

# ---- Get project name ----
if {[llength $argv] >= 1} {
    set project_name [lindex $argv 0]
} else {
    puts -nonewline "Enter Vivado project name: "
    flush stdout
    gets stdin project_name

    if {$project_name eq ""} {
        error "Project name cannot be empty."
    }
}

# ---- User-configurable FPGA part ----
set part_name "xc7a35tcsg324-1"   ;# CHANGE if needed

# ---- Paths ----
set script_dir [file dirname [file normalize [info script]]]
set repo_root  [file dirname $script_dir]
# Put Vivado-generated log/jou in build/
set build_root [file normalize "$repo_root/build"]
file mkdir $build_root
cd $build_root
set project_dir [file normalize "$repo_root/build/$project_name"]

set rtl_dir    "$repo_root/rtl"
set tb_dir     "$repo_root/tb"
set constr_dir "$repo_root/constraints"

# ---- Create project ----
create_project $project_name $project_dir -part $part_name -force

# ---- RTL sources ----
if {[file exists $rtl_dir]} {
    set rtl_files [glob -nocomplain \
        $rtl_dir/*.v \
        $rtl_dir/*.sv \
        $rtl_dir/*.vhd \
        $rtl_dir/*.vhdl]

    if {[llength $rtl_files] > 0} {
        add_files -fileset sources_1 $rtl_files
        puts "Added RTL files:"
        puts $rtl_files
    }
}

# ---- Testbench sources ----
if {[file exists $tb_dir]} {
    set tb_files [glob -nocomplain \
        $tb_dir/*.v \
        $tb_dir/*.sv \
        $tb_dir/*.vhd \
        $tb_dir/*.vhdl]

    if {[llength $tb_files] > 0} {
        add_files -fileset sim_1 $tb_files
        puts "Added Testbench files:"
        puts $tb_files
    }
}

# ---- Constraints ----
if {[file exists $constr_dir]} {
    set xdc_files [glob -nocomplain $constr_dir/*.xdc]

    if {[llength $xdc_files] > 0} {
        add_files -fileset constrs_1 $xdc_files
        puts "Added Constraints:"
        puts $xdc_files
    }
}

# ---- Project settings ----
set_property target_language Verilog [current_project]
set_property simulator_language Mixed [current_project]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "Vivado project '$project_name' created successfully."

# ---- Open project in GUI if available ----
if {[info exists ::env(DISPLAY)] || [info commands start_gui] ne ""} {
    catch { start_gui }
}
puts "Project created. Exiting TCL script."
