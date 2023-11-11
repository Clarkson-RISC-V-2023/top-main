`include "uvm_macros.svh"
import uvm_pkg::*;

import top_params::*;

module tb_uvm_top;
        
    reg clk, rst_n, serial, programming_mode;
    reg [TOP_DATA_WIDTH-1:0] gpioA, gpioB;

    riscv_if vif(clk, rst_n);

    top dut_top(
        .clk_i(vif.DUT.clk),
        .reset_n(vif.DUT.reset_n),
        .serial_i(vif.DUT.serial_i),
        .programming_mode(vif.DUT.programming_mode),
        .gpioA_out(vif.DUT.gpioA_out),
        .gpioB_in(vif.DUT.gpioB_in)
        ); // Connecting the DUT to the interface using the DUT modport

    initial begin
        clk = 0;
        rst_n = 1;

        uvm_config_db #(virtual riscv_if)::set(uvm_root::get(), "*", "top_vif", vif.TB);

        run_test("riscv_base_test");
    end

endmodule