set PROJECT_NAME                RISCy_Buisness_Processor
set PROJECT_CONSTRAINT_FILE     ./vivado/riscy.xdc

set OUT_DIR                     ./out/vivado_project

set PART_NUM                    xc7a100tcsg324-1
set BOARD                       digilentinc.com:nexys4:part0:1.1

exec mkdir -p $OUT_DIR

create_project $PROJECT_NAME $OUT_DIR -part $PART_NUM
set_property board_part $BOARD [current_project]
set_property simulator_language Verilog [current_project]

add_files -fileset constrs_1 -norecurse $PROJECT_CONSTRAINT_FILE

source ./vivado/read_verilog_rtl.tcl

set_property top top [current_fileset]
update_compile_order -fileset sources_1

# Launch Synthesis and wait on completion
synth_design -top top -part $PART_NUM -lint

# Generate a timing and power reports and write to disk
report_timing_summary -delay_type max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file ${DIR_OUTPUT}/syn_timing.rpt
report_power -file ${DIR_OUTPUT}/syn_power.rpt

# Launch Implementation
launch_runs RISCy_impl_1 -to_step write_bitstream
wait_on_run RISCy_impl_1 

# Generate a timing and power reports and write to disk
# comment out the open_run for batch mode
open_run RISCy_impl_1
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file ${DIR_OUTPUT}/imp_timing.rpt
report_power -file ${DIR_OUTPUT}/imp_power.rpt
