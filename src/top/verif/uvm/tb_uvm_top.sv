`include "uvm_macros.svh"
import uvm_pkg::*;

import ram_params::*;

module tb_uvm_ram;

    reg clk;
    reg rst_n;

    logic [ROM_DEPTH-1:0] ROM [DATA_WIDTH-1:0]; 

    always #10 clk = ~clk;

    top_vif vif (
        .clk(clk)
    );

    assign ROM = vif.ROM_mem;

    top dut_top (
        .clk(clk),
        .reset_n(rst_n),
        .gpioA_out(vif.gpioA),
        .gpioB_out(vif.gpioB)
    );

    // bind top.regs_inst vif(
    //     .reg_file_rs1(RA1_i),
    //     .reg_file_rs2(RA2_i),
    //     .reg_file_rd(WA_i)
    //     .reg_file_din(WD_i),
    //     .reg_file_we(WE_i),
    //     .reg_file_rd1(RD1_o),
    //     .reg_file_rd2(RD2_o),
        
    // )
    //     .regs_inst.RA1_i(vif.reg_file_rs1),
    //     .regs_inst.RA2_i(vif.reg_file_rs2),
    //     .regs_inst.WA_i(vif.reg_file_rd),
    //     .regs_inst.WD_i(vif.reg_file_din),
    //     .regs_inst.WE_i(vif.reg_file_we),
    //     .regs_inst.RD1_o(vif.reg_file_rd1),
    //     .regs_inst.RD2_o(vif.reg_file_rd2),
    //     .instruction_rom.mem_inst.bmem(vif.ROM_mem), 
    //     .ialu_inst.signed_B(vif.ialu_imm) // For i-type like addi and li

    initial begin
        //$dumpvars;
        // $dumpfile("tb_uvm_ram.vcd");
        creat_mem_init_hex("Test");
        clk <= 0;
        rst_n <= 0;
        #200;
        rst_n <= 1;

        uvm_config_db #(virtual top_vif)::set(uvm_root::get(), "*", "top_vif", vif);

        run_test("verify_ialu_addi");
    end

    task creat_mem_init_hex (string filename);
        int file;
        file = $fopen(filename, "w");
        if (file) $display("File was opened succesfully : %0d", fd);
        else $display("File was not opened succesfully : %0d", fd);
        $fclose(file);
        
    endtask
        
endmodule