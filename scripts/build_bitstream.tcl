# scripts/build_bitstream.tcl
set proj_dir [file normalize "./build"]
set xpr      [glob -nocomplain "$proj_dir/*.xpr"]

if {[llength $xpr] == 0} {
  puts "ERROR: No .xpr found. Run create_project.tcl first."
  exit 1
}

open_project [lindex $xpr 0]

reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1

reset_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

puts "OK: Build complete"
