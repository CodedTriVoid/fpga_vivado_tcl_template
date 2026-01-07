# scripts/create_project.tcl
set proj_name my_proj
set proj_dir  [file normalize "./build"]
set part      xc7a35tcpg236-1  ;# change this

create_project $proj_name $proj_dir -part $part -force

# Add sources
add_files [glob -nocomplain ../rtl/*]
add_files -fileset constrs_1 [glob -nocomplain ../constraints/*.xdc]

# Set top module (change "top")
set_property top top [current_fileset]

update_compile_order -fileset sources_1
puts "OK: Project created in $proj_dir"
