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

# Optimized Synthesis and Implementation
set_property strategy Flow_PerfOptimized_high [get_runs synth_1]
# set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
set_property strategy Performance_NetDelay_high [get_runs impl_1]
# set_property STEPS.POWER_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
# set_property STEPS.POST_PLACE_POWER_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]

# Create PLL CLK 
# TODO maybe this should in an external file...
create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name riscy_clk_wizard
set_property -dict [list \
  CONFIG.CLKOUT1_DRIVES {BUFG} \
  CONFIG.CLKOUT1_JITTER {137.681} \
  CONFIG.CLKOUT1_PHASE_ERROR {105.461} \
  CONFIG.CLKOUT2_DRIVES {BUFG} \
  CONFIG.CLKOUT2_JITTER {183.467} \
  CONFIG.CLKOUT2_PHASE_ERROR {105.461} \
  CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {25.000} \
  CONFIG.CLKOUT2_USED {true} \
  CONFIG.CLKOUT3_DRIVES {BUFG} \
  CONFIG.CLKOUT4_DRIVES {BUFG} \
  CONFIG.CLKOUT5_DRIVES {BUFG} \
  CONFIG.CLKOUT6_DRIVES {BUFG} \
  CONFIG.CLKOUT7_DRIVES {BUFG} \
  CONFIG.CLK_IN1_BOARD_INTERFACE {sys_clock} \
  CONFIG.CLK_OUT1_PORT {clk_100} \
  CONFIG.CLK_OUT2_PORT {clk_25} \
  CONFIG.MMCM_BANDWIDTH {OPTIMIZED} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {9} \
  CONFIG.MMCM_CLKOUT0_DIVIDE_F {9} \
  CONFIG.MMCM_CLKOUT1_DIVIDE {36} \
  CONFIG.MMCM_COMPENSATION {ZHOLD} \
  CONFIG.NUM_OUT_CLKS {2} \
  CONFIG.PRIMARY_PORT {sys_clk} \
  CONFIG.PRIMITIVE {PLL} \
  CONFIG.PRIM_SOURCE {Single_ended_clock_capable_pin} \
  CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
  CONFIG.USE_FREQ_SYNTH {true} \
  CONFIG.USE_LOCKED {false} \
  CONFIG.USE_PHASE_ALIGNMENT {true} \
  CONFIG.USE_RESET {false} \
] [get_ips riscy_clk_wizard]
generate_target {instantiation_template} [get_files $OUT_DIR/RISCy_Buisness_Processor.srcs/sources_1/ip/riscy_clk_wizard/riscy_clk_wizard.xci]
update_compile_order -fileset sources_1
set_property generate_synth_checkpoint false [get_files  $OUT_DIR/RISCy_Buisness_Processor.srcs/sources_1/ip/riscy_clk_wizard/riscy_clk_wizard.xci]
generate_target all [get_files  $OUT_DIR/RISCy_Buisness_Processor.srcs/sources_1/ip/riscy_clk_wizard/riscy_clk_wizard.xci]
export_ip_user_files -of_objects [get_files $OUT_DIR/RISCy_Buisness_Processor.srcs/sources_1/ip/riscy_clk_wizard/riscy_clk_wizard.xci] -no_script -sync -force -quiet
export_simulation -of_objects [get_files $OUT_DIR/RISCy_Buisness_Processor.srcs/sources_1/ip/riscy_clk_wizard/riscy_clk_wizard.xci] -directory $OUT_DIR/RISCy_Buisness_Processor.ip_user_files/sim_scripts -ip_user_files_dir $OUT_DIR/RISCy_Buisness_Processor.ip_user_files -ipstatic_source_dir $OUT_DIR/RISCy_Buisness_Processor.ip_user_files/ipstatic -lib_map_path [list {modelsim=$OUT_DIR/RISCy_Buisness_Processor.cache/compile_simlib/modelsim} {questa=$OUT_DIR/RISCy_Buisness_Processor.cache/compile_simlib/questa} {xcelium=$OUT_DIR/RISCy_Buisness_Processor.cache/compile_simlib/xcelium} {vcs=$OUT_DIR/RISCy_Buisness_Processor.cache/compile_simlib/vcs} {riviera=$OUT_DIR/RISCy_Buisness_Processor.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet

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

source ./vivado/generate_xdc.tcl

# Generate debug core
if {$DEBUG == "True"} {
    source ./vivado/generate_debug_core.tcl
}

file mkdir $OUT_DIR/$PROJECT_NAME.srcs/constrs_1/new
close [ open $OUT_DIR/$PROJECT_NAME.srcs/constrs_1/new/riscy_constraints.xdc w ]
add_files -fileset constrs_1 $OUT_DIR/$PROJECT_NAME.srcs/constrs_1/new/riscy_constraints.xdc
set_property target_constrs_file $OUT_DIR/$PROJECT_NAME.srcs/constrs_1/new/riscy_constraints.xdc [current_fileset -constrset]
save_constraints -force

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
