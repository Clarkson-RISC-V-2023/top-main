`include "uvm_macros.svh"
import uvm_pkg::*;

import top_params::*;

module tb_uvm_top;
        
    reg clk;
    wire [7:0] ROM_DV;

    riscv_if vif(
        clk,
        ROM_DV
    );

    top dut_top(
        .clk_i(vif.DUT.clk),
        .reset_n(vif.DUT.reset_n),
        .serial_i(vif.DUT.serial_i),
        .programming_mode(vif.DUT.programming_mode),
        .gpioA_out(vif.DUT.gpioA_out),
        .gpioB_in(vif.DUT.gpioB_in)
        ); // Connecting the DUT to the interface using the DUT modport

    assign ROM_DV = dut_top.instruction_rom.uart_inst.o_RX_DV;
    
    UART_TX #(
        .CLKS_PER_BIT(ROM_BAUD_FACTOR)
        )tx_inst(
        .uvm_driver_en(vif.TX.uvm_driver_en),
        .i_Rst_L(vif.TX.TX_rst),
        .i_Clock(vif.TX.clk),
        .i_TX_DV(ROM_DV),
        .i_TX_Byte(vif.TX.TX_Byte),
        .o_TX_Serial(vif.TX.serial_i)
    );

    always #10 clk = ~clk;

    initial begin
        $dumpfile("tb_uvm_top.vcd");
        $dumpvars(0, tb_uvm_top);
        clk = 0;

        uvm_config_db #(virtual riscv_if)::set(uvm_root::get(), "*", "top_vif", vif.TB);

        run_test("riscv_base_test");
    end

endmodule