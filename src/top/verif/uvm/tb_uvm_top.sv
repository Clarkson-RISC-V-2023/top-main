`include "uvm_macros.svh"
import uvm_pkg::*;

import ram_params::*;

module tb_uvm_ram;

    reg clk;
    reg rst_n;

    always #10 clk = ~clk;
    
    top_vif vif (
        .clk(clk)
    );

    top dut_top (
        .clk(clk),
        .reset_n(rst_n),
        .gpioA_out(vif.gpioA),
        .gpioB_out(vif.gpioB),
        .regs_inst.RA1_i(vif.reg_file_rs1),
        .regs_inst.RA2_i(vif.reg_file_rs2),
        .regs_inst.WA_i(vif.reg_file_rd),
        .regs_inst.WD_i(vif.reg_file_din),
        .regs_inst.WE_i(vif.reg_file_we),
        .regs_inst.RD1_o(vif.reg_file_rd1),
        .regs_inst.RD2_o(vif.reg_file_rd2),
        .instruction_rom.mem_inst.bmem(vif.ROM_mem)
    );

    initial begin
        $dumpvars;
        // $dumpfile("tb_uvm_ram.vcd");

        clk <= 0;
        rst_n <= 0;
        #200;
        rst_n <= 1;

        uvm_config_db #(virtual ram_if)::set(uvm_root::get(), "*", "ram_vif", vif);

        run_test("verify_ram_test");
    end

endmodule