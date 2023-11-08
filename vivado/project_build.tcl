set PROJECT_NAME                RISCy_Buisness_Processor
set PROJECT_CONSTRAINT_FILE     ./vivado/riscy_seven_seg.xdc

set OUT_DIR                     ./out/vivado_project                     

set PART_NUM                    xc7a100tcsg324-1
set BOARD                       digilentinc.com:nexys4:part0:1.1

set board.repoPaths /opt/Vivado/2023.1/data/xhub/boards/

set ATTACH_MODE [lindex $::argv 0]
set DEBUG [lindex $::argv 1]

exec mkdir -p $OUT_DIR

create_project $PROJECT_NAME $OUT_DIR -part $PART_NUM -force

set_property board_part $BOARD [current_project]
set_property simulator_language Verilog [current_project]

# Attached or Detached
if {$ATTACH_MODE == "Attached"} {
    puts "Building Attached"
    source ./vivado/read_verilog_rtl.tcl
} else {
    puts "Building Detached"
    source ./vivado/load_verilog_rtl.tcl
}


set_property top top [current_fileset]
update_compile_order -fileset sources_1

# Launch Vivado linter
synth_design -top top -part $PART_NUM -lint

set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]

# Launch Synthesis and wait on completion
launch_runs synth_1 -jobs 8
wait_on_run synth_1

# Generate a timing and power reports and write to disk
open_run synth_1
report_timing_summary -delay_type max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file $OUT_DIR/syn_timing.rpt
report_power -file $OUT_DIR/syn_power.rpt

# Generate debug core
if {$DEBUG == "True"} {
    source ./vivado/generate_debug_core.tcl
}

close_design

# Launch Implementation
launch_runs impl_1 -jobs 8
wait_on_run impl_1

# Generate a timing and power reports and write to disk
# comment out the open_run for batch mode
open_run impl_1
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file $OUT_DIR/imp_timing.rpt
report_power -file $OUT_DIR/imp_power.rpt
close_design

# # Generate Bitstream
launch_runs impl_1 -to_step write_bitstream -jobs 8

write_project_tcl -all_properties -use_bd_files -dump_project_info -force $OUT_DIR/run_me.tcl
if {$rdi::mode != "gui"} {
    close_project
}
