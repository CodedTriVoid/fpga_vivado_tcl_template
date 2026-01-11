# =========================================================
# Import sources from an existing .xpr into repo folders
# Run inside Vivado batch:
#   vivado -mode batch -source scripts/vivado/import_from_existing_project.tcl -tclargs path/to/project.xpr
# =========================================================

# --- Path helpers (repo root is 2 levels up from scripts/vivado/) ---
set script_dir [file dirname [file normalize [info script]]]
set repo_root  [file normalize [file join $script_dir "../.."]]

set rtl_dir    [file join $repo_root "rtl"]
set xdc_dir    [file join $repo_root "constraints"]
set tb_dir     [file join $repo_root "tb"]

file mkdir $rtl_dir
file mkdir $xdc_dir
file mkdir $tb_dir

# --- Read args ---
if {$argc < 1} {
    puts "ERROR: Provide path to .xpr as argument."
    puts "Example: vivado -mode batch -source scripts/vivado/import_from_existing_project.tcl -tclargs C:/path/proj.xpr"
    exit 1
}
set xpr_path [file normalize [lindex $argv 0]]

puts "Opening project: $xpr_path"
open_project $xpr_path

# --- Collect sources ---
# RTL sources (VHDL/Verilog/SystemVerilog)
set rtl_files [get_files -of_objects [get_filesets sources_1]]
# Constraints
set xdc_files [get_files -of_objects [get_filesets constrs_1]]
# Simulation sources
set sim_files [get_files -of_objects [get_filesets sim_1]]

proc copy_list {files dest_dir label} {
    set copied 0
    foreach f $files {
        set f_norm [file normalize $f]
        # Skip generated / junk paths
        if {[string match "*\\.Xil\\*" $f_norm] || [string match "*\\.runs\\*" $f_norm] || [string match "*\\.cache\\*" $f_norm]} {
            continue
        }
        if {![file exists $f_norm]} {
            continue
        }
        # Only copy "real" files
        if {[file isdirectory $f_norm]} {
            continue
        }
        set out [file join $dest_dir [file tail $f_norm]]
        if {$f_norm ne $out} {
            file copy -force $f_norm $out
            incr copied
        }
    }
    puts "✔ Copied $copied $label files into $dest_dir"
}

# Filter by extension a bit to avoid weird non-HDL files
set rtl_filtered {}
foreach f $rtl_files {
    if {[regexp {(\.vhd|\.vhdl|\.v|\.sv)$} $f]} { lappend rtl_filtered $f }
}
set xdc_filtered {}
foreach f $xdc_files {
    if {[regexp {(\.xdc)$} $f]} { lappend xdc_filtered $f }
}
set sim_filtered {}
foreach f $sim_files {
    if {[regexp {(\.vhd|\.vhdl|\.v|\.sv)$} $f]} { lappend sim_filtered $f }
}

copy_list $rtl_filtered $rtl_dir "RTL"
copy_list $xdc_filtered $xdc_dir "XDC"
copy_list $sim_filtered $tb_dir  "TB"

puts "Done. Now regenerate your repo-based project with create_project.tcl."
close_project
