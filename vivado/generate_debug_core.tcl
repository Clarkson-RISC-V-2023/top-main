create_debug_core u_ila_0 ila
set_property C_DATA_DEPTH 8192 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
startgroup 
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0 ]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0 ]
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0 ]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0 ]
endgroup
connect_debug_port u_ila_0/clk [get_nets [list clk_BUFG ]]
set_property port_width 5 [get_debug_ports u_ila_0/probe0]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {regs_inst/WA_i[0]} {regs_inst/WA_i[1]} {regs_inst/WA_i[2]} {regs_inst/WA_i[3]} {regs_inst/WA_i[4]} ]]
create_debug_port u_ila_0 probe
set_property port_width 5 [get_debug_ports u_ila_0/probe1]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {regs_inst/RA1_i[0]} {regs_inst/RA1_i[1]} {regs_inst/RA1_i[2]} {regs_inst/RA1_i[3]} {regs_inst/RA1_i[4]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe2]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {regs_inst/RD1_o[0]} {regs_inst/RD1_o[1]} {regs_inst/RD1_o[2]} {regs_inst/RD1_o[3]} {regs_inst/RD1_o[4]} {regs_inst/RD1_o[5]} {regs_inst/RD1_o[6]} {regs_inst/RD1_o[7]} {regs_inst/RD1_o[8]} {regs_inst/RD1_o[9]} {regs_inst/RD1_o[10]} {regs_inst/RD1_o[11]} {regs_inst/RD1_o[12]} {regs_inst/RD1_o[13]} {regs_inst/RD1_o[14]} {regs_inst/RD1_o[15]} {regs_inst/RD1_o[16]} {regs_inst/RD1_o[17]} {regs_inst/RD1_o[18]} {regs_inst/RD1_o[19]} {regs_inst/RD1_o[20]} {regs_inst/RD1_o[21]} {regs_inst/RD1_o[22]} {regs_inst/RD1_o[23]} {regs_inst/RD1_o[24]} {regs_inst/RD1_o[25]} {regs_inst/RD1_o[26]} {regs_inst/RD1_o[27]} {regs_inst/RD1_o[28]} {regs_inst/RD1_o[29]} {regs_inst/RD1_o[30]} {regs_inst/RD1_o[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {regs_inst/RD2_o[0]} {regs_inst/RD2_o[1]} {regs_inst/RD2_o[2]} {regs_inst/RD2_o[3]} {regs_inst/RD2_o[4]} {regs_inst/RD2_o[5]} {regs_inst/RD2_o[6]} {regs_inst/RD2_o[7]} {regs_inst/RD2_o[8]} {regs_inst/RD2_o[9]} {regs_inst/RD2_o[10]} {regs_inst/RD2_o[11]} {regs_inst/RD2_o[12]} {regs_inst/RD2_o[13]} {regs_inst/RD2_o[14]} {regs_inst/RD2_o[15]} {regs_inst/RD2_o[16]} {regs_inst/RD2_o[17]} {regs_inst/RD2_o[18]} {regs_inst/RD2_o[19]} {regs_inst/RD2_o[20]} {regs_inst/RD2_o[21]} {regs_inst/RD2_o[22]} {regs_inst/RD2_o[23]} {regs_inst/RD2_o[24]} {regs_inst/RD2_o[25]} {regs_inst/RD2_o[26]} {regs_inst/RD2_o[27]} {regs_inst/RD2_o[28]} {regs_inst/RD2_o[29]} {regs_inst/RD2_o[30]} {regs_inst/RD2_o[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {regs_inst/WD_i[0]} {regs_inst/WD_i[1]} {regs_inst/WD_i[2]} {regs_inst/WD_i[3]} {regs_inst/WD_i[4]} {regs_inst/WD_i[5]} {regs_inst/WD_i[6]} {regs_inst/WD_i[7]} {regs_inst/WD_i[8]} {regs_inst/WD_i[9]} {regs_inst/WD_i[10]} {regs_inst/WD_i[11]} {regs_inst/WD_i[12]} {regs_inst/WD_i[13]} {regs_inst/WD_i[14]} {regs_inst/WD_i[15]} {regs_inst/WD_i[16]} {regs_inst/WD_i[17]} {regs_inst/WD_i[18]} {regs_inst/WD_i[19]} {regs_inst/WD_i[20]} {regs_inst/WD_i[21]} {regs_inst/WD_i[22]} {regs_inst/WD_i[23]} {regs_inst/WD_i[24]} {regs_inst/WD_i[25]} {regs_inst/WD_i[26]} {regs_inst/WD_i[27]} {regs_inst/WD_i[28]} {regs_inst/WD_i[29]} {regs_inst/WD_i[30]} {regs_inst/WD_i[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 5 [get_debug_ports u_ila_0/probe5]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {regs_inst/RA2_i[0]} {regs_inst/RA2_i[1]} {regs_inst/RA2_i[2]} {regs_inst/RA2_i[3]} {regs_inst/RA2_i[4]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {branch_inst/register_2[0]} {branch_inst/register_2[1]} {branch_inst/register_2[2]} {branch_inst/register_2[3]} {branch_inst/register_2[4]} {branch_inst/register_2[5]} {branch_inst/register_2[6]} {branch_inst/register_2[7]} {branch_inst/register_2[8]} {branch_inst/register_2[9]} {branch_inst/register_2[10]} {branch_inst/register_2[11]} {branch_inst/register_2[12]} {branch_inst/register_2[13]} {branch_inst/register_2[14]} {branch_inst/register_2[15]} {branch_inst/register_2[16]} {branch_inst/register_2[17]} {branch_inst/register_2[18]} {branch_inst/register_2[19]} {branch_inst/register_2[20]} {branch_inst/register_2[21]} {branch_inst/register_2[22]} {branch_inst/register_2[23]} {branch_inst/register_2[24]} {branch_inst/register_2[25]} {branch_inst/register_2[26]} {branch_inst/register_2[27]} {branch_inst/register_2[28]} {branch_inst/register_2[29]} {branch_inst/register_2[30]} {branch_inst/register_2[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {branch_inst/register_1[0]} {branch_inst/register_1[1]} {branch_inst/register_1[2]} {branch_inst/register_1[3]} {branch_inst/register_1[4]} {branch_inst/register_1[5]} {branch_inst/register_1[6]} {branch_inst/register_1[7]} {branch_inst/register_1[8]} {branch_inst/register_1[9]} {branch_inst/register_1[10]} {branch_inst/register_1[11]} {branch_inst/register_1[12]} {branch_inst/register_1[13]} {branch_inst/register_1[14]} {branch_inst/register_1[15]} {branch_inst/register_1[16]} {branch_inst/register_1[17]} {branch_inst/register_1[18]} {branch_inst/register_1[19]} {branch_inst/register_1[20]} {branch_inst/register_1[21]} {branch_inst/register_1[22]} {branch_inst/register_1[23]} {branch_inst/register_1[24]} {branch_inst/register_1[25]} {branch_inst/register_1[26]} {branch_inst/register_1[27]} {branch_inst/register_1[28]} {branch_inst/register_1[29]} {branch_inst/register_1[30]} {branch_inst/register_1[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 3 [get_debug_ports u_ila_0/probe8]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {branch_inst/branch_type[0]} {branch_inst/branch_type[1]} {branch_inst/branch_type[2]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe9]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {instruction[0]} {instruction[1]} {instruction[2]} {instruction[3]} {instruction[4]} {instruction[5]} {instruction[6]} {instruction[7]} {instruction[8]} {instruction[9]} {instruction[10]} {instruction[11]} {instruction[12]} {instruction[13]} {instruction[14]} {instruction[15]} {instruction[16]} {instruction[17]} {instruction[18]} {instruction[19]} {instruction[20]} {instruction[21]} {instruction[22]} {instruction[23]} {instruction[24]} {instruction[25]} {instruction[26]} {instruction[27]} {instruction[28]} {instruction[29]} {instruction[30]} {instruction[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 20 [get_debug_ports u_ila_0/probe10]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {jump_inst/JAL_in[0]} {jump_inst/JAL_in[1]} {jump_inst/JAL_in[2]} {jump_inst/JAL_in[3]} {jump_inst/JAL_in[4]} {jump_inst/JAL_in[5]} {jump_inst/JAL_in[6]} {jump_inst/JAL_in[7]} {jump_inst/JAL_in[8]} {jump_inst/JAL_in[9]} {jump_inst/JAL_in[10]} {jump_inst/JAL_in[11]} {jump_inst/JAL_in[12]} {jump_inst/JAL_in[13]} {jump_inst/JAL_in[14]} {jump_inst/JAL_in[15]} {jump_inst/JAL_in[16]} {jump_inst/JAL_in[17]} {jump_inst/JAL_in[18]} {jump_inst/JAL_in[19]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe11]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {jump_inst/addr_out[0]} {jump_inst/addr_out[1]} {jump_inst/addr_out[2]} {jump_inst/addr_out[3]} {jump_inst/addr_out[4]} {jump_inst/addr_out[5]} {jump_inst/addr_out[6]} {jump_inst/addr_out[7]} {jump_inst/addr_out[8]} {jump_inst/addr_out[9]} {jump_inst/addr_out[10]} {jump_inst/addr_out[11]} {jump_inst/addr_out[12]} {jump_inst/addr_out[13]} {jump_inst/addr_out[14]} {jump_inst/addr_out[15]} {jump_inst/addr_out[16]} {jump_inst/addr_out[17]} {jump_inst/addr_out[18]} {jump_inst/addr_out[19]} {jump_inst/addr_out[20]} {jump_inst/addr_out[21]} {jump_inst/addr_out[22]} {jump_inst/addr_out[23]} {jump_inst/addr_out[24]} {jump_inst/addr_out[25]} {jump_inst/addr_out[26]} {jump_inst/addr_out[27]} {jump_inst/addr_out[28]} {jump_inst/addr_out[29]} {jump_inst/addr_out[30]} {jump_inst/addr_out[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 3 [get_debug_ports u_ila_0/probe12]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {jump_inst/type_in[0]} {jump_inst/type_in[1]} {jump_inst/type_in[2]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe13]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {ialu_inst/A_i[0]} {ialu_inst/A_i[1]} {ialu_inst/A_i[2]} {ialu_inst/A_i[3]} {ialu_inst/A_i[4]} {ialu_inst/A_i[5]} {ialu_inst/A_i[6]} {ialu_inst/A_i[7]} {ialu_inst/A_i[8]} {ialu_inst/A_i[9]} {ialu_inst/A_i[10]} {ialu_inst/A_i[11]} {ialu_inst/A_i[12]} {ialu_inst/A_i[13]} {ialu_inst/A_i[14]} {ialu_inst/A_i[15]} {ialu_inst/A_i[16]} {ialu_inst/A_i[17]} {ialu_inst/A_i[18]} {ialu_inst/A_i[19]} {ialu_inst/A_i[20]} {ialu_inst/A_i[21]} {ialu_inst/A_i[22]} {ialu_inst/A_i[23]} {ialu_inst/A_i[24]} {ialu_inst/A_i[25]} {ialu_inst/A_i[26]} {ialu_inst/A_i[27]} {ialu_inst/A_i[28]} {ialu_inst/A_i[29]} {ialu_inst/A_i[30]} {ialu_inst/A_i[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe14]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {ialu_inst/B_i[0]} {ialu_inst/B_i[1]} {ialu_inst/B_i[2]} {ialu_inst/B_i[3]} {ialu_inst/B_i[4]} {ialu_inst/B_i[5]} {ialu_inst/B_i[6]} {ialu_inst/B_i[7]} {ialu_inst/B_i[8]} {ialu_inst/B_i[9]} {ialu_inst/B_i[10]} {ialu_inst/B_i[11]} {ialu_inst/B_i[12]} {ialu_inst/B_i[13]} {ialu_inst/B_i[14]} {ialu_inst/B_i[15]} {ialu_inst/B_i[16]} {ialu_inst/B_i[17]} {ialu_inst/B_i[18]} {ialu_inst/B_i[19]} {ialu_inst/B_i[20]} {ialu_inst/B_i[21]} {ialu_inst/B_i[22]} {ialu_inst/B_i[23]} {ialu_inst/B_i[24]} {ialu_inst/B_i[25]} {ialu_inst/B_i[26]} {ialu_inst/B_i[27]} {ialu_inst/B_i[28]} {ialu_inst/B_i[29]} {ialu_inst/B_i[30]} {ialu_inst/B_i[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe15]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {ialu_inst/R_o[0]} {ialu_inst/R_o[1]} {ialu_inst/R_o[2]} {ialu_inst/R_o[3]} {ialu_inst/R_o[4]} {ialu_inst/R_o[5]} {ialu_inst/R_o[6]} {ialu_inst/R_o[7]} {ialu_inst/R_o[8]} {ialu_inst/R_o[9]} {ialu_inst/R_o[10]} {ialu_inst/R_o[11]} {ialu_inst/R_o[12]} {ialu_inst/R_o[13]} {ialu_inst/R_o[14]} {ialu_inst/R_o[15]} {ialu_inst/R_o[16]} {ialu_inst/R_o[17]} {ialu_inst/R_o[18]} {ialu_inst/R_o[19]} {ialu_inst/R_o[20]} {ialu_inst/R_o[21]} {ialu_inst/R_o[22]} {ialu_inst/R_o[23]} {ialu_inst/R_o[24]} {ialu_inst/R_o[25]} {ialu_inst/R_o[26]} {ialu_inst/R_o[27]} {ialu_inst/R_o[28]} {ialu_inst/R_o[29]} {ialu_inst/R_o[30]} {ialu_inst/R_o[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 5 [get_debug_ports u_ila_0/probe16]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {decoder_inst/ALUOp[0]} {decoder_inst/ALUOp[1]} {decoder_inst/ALUOp[2]} {decoder_inst/ALUOp[3]} {decoder_inst/ALUOp[4]} ]]
create_debug_port u_ila_0 probe
set_property port_width 3 [get_debug_ports u_ila_0/probe17]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {decoder_inst/dType[0]} {decoder_inst/dType[1]} {decoder_inst/dType[2]} ]]
create_debug_port u_ila_0 probe
set_property port_width 3 [get_debug_ports u_ila_0/probe18]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {decoder_inst/rawType[0]} {decoder_inst/rawType[1]} {decoder_inst/rawType[2]} ]]
create_debug_port u_ila_0 probe
set_property port_width 12 [get_debug_ports u_ila_0/probe19]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list {branch_inst/branch_imm[0]} {branch_inst/branch_imm[1]} {branch_inst/branch_imm[2]} {branch_inst/branch_imm[3]} {branch_inst/branch_imm[4]} {branch_inst/branch_imm[5]} {branch_inst/branch_imm[6]} {branch_inst/branch_imm[7]} {branch_inst/branch_imm[8]} {branch_inst/branch_imm[9]} {branch_inst/branch_imm[10]} {branch_inst/branch_imm[11]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe20]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list {gpioA_out_OBUF[0]} {gpioA_out_OBUF[1]} {gpioA_out_OBUF[2]} {gpioA_out_OBUF[3]} {gpioA_out_OBUF[4]} {gpioA_out_OBUF[5]} {gpioA_out_OBUF[6]} {gpioA_out_OBUF[7]} {gpioA_out_OBUF[8]} {gpioA_out_OBUF[9]} {gpioA_out_OBUF[10]} {gpioA_out_OBUF[11]} {gpioA_out_OBUF[12]} {gpioA_out_OBUF[13]} {gpioA_out_OBUF[14]} {gpioA_out_OBUF[15]} {gpioA_out_OBUF[16]} {gpioA_out_OBUF[17]} {gpioA_out_OBUF[18]} {gpioA_out_OBUF[19]} {gpioA_out_OBUF[20]} {gpioA_out_OBUF[21]} {gpioA_out_OBUF[22]} {gpioA_out_OBUF[23]} {gpioA_out_OBUF[24]} {gpioA_out_OBUF[25]} {gpioA_out_OBUF[26]} {gpioA_out_OBUF[27]} {gpioA_out_OBUF[28]} {gpioA_out_OBUF[29]} {gpioA_out_OBUF[30]} {gpioA_out_OBUF[31]} ]]
file mkdir ./vivado_project/RISCy_Buisness_Processor.srcs/constrs_1/new
close [ open ./vivado_project/RISCy_Buisness_Processor.srcs/constrs_1/new/debug_riscy.xdc w ]
add_files -fileset constrs_1 ./vivado_project/RISCy_Buisness_Processor.srcs/constrs_1/new/debug_riscy.xdc
set_property target_constrs_file ./vivado_project/RISCy_Buisness_Processor.srcs/constrs_1/new/debug_riscy.xdc [current_fileset -constrset]
save_constraints -force