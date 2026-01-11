# =========================================================
# create_project.tcl (robust)
# =========================================================

# Absolute directory where this script lives
set script_dir [file dirname [file normalize [info script]]]

# Because your script is in: repo/scripts/create_project.tcl
# repo_root is one level up from script_dir
set repo_root  [file normalize [file join $script_dir ".."]]

# Build directory inside repo (generated)
set proj_dir   [file normalize [file join $repo_root "build" "vivado"]]

# ===== USER CONFIG =====
set proj_name  my_vivado_project
set part       xc7a35tcpg236-1      ;# CHANGE if needed
set top_module top                 ;# CHANGE if needed

# Make build directory
file mkdir $proj_dir

# Create project
create_project $proj_name $proj_dir -part $part -force

# --- Add RTL (only if it exists) ---
set rtl_files [glob -nocomplain -directory [file join $repo_root "rtl"] *]
if {[llength $rtl_files] > 0} {
    add_files $rtl_files
    puts "✔ Added RTL files: $rtl_files"
} else {
    puts "⚠ No RTL files found in [file join $repo_root rtl]"
}

# --- Add constraints (only if they exist) ---
set xdc_files [glob -nocomplain -directory [file join $repo_root "constraints"] *.xdc]
if {[llength $xdc_files] > 0} {
    add_files -fileset constrs_1 $xdc_files
    puts "✔ Added XDC files: $xdc_files"
} else {
    puts "⚠ No XDC files found in [file join $repo_root constraints]"
}

# Set top module (only meaningful once RTL exists)
set_property top $top_module [current_fileset]
update_compile_order -fileset sources_1

puts "✔ Project created at: $proj_dir"
puts "Repo root detected as: $repo_root"
