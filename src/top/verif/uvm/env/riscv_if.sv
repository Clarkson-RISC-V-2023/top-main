`include "uvm_macros.svh"
import uvm_pkg::*;
import top_params::*;

interface riscv_if(input wire clk, input wire [7:0] ROM_DV);

    // Signal declarations
    reg programming_mode, uvm_driver_en, reset_n, serial_i;
    wire TX_rst;

    reg [TOP_DATA_WIDTH-1:0] gpioA_out;
    wire [TOP_DATA_WIDTH-1:0] gpioB_in;
    reg [7:0] TX_Byte;

    // Add additional signals as per your requirement

    // Modport for the DUT side
    modport DUT (
        input clk, 
        input reset_n, 
        input serial_i,
        output programming_mode,
        output gpioA_out,
        input gpioB_in
    );


    // Modport for the Testbench side
    modport TB (
        output reset_n, serial_i, gpioB_in, TX_Byte, uvm_driver_en,
        input clk, programming_mode, gpioA_out, ROM_DV
        // Add additional signals as per your requirement
    );

    assign TX_rst = ~reset_n;
    modport TX (
        input uvm_driver_en,
        input clk,
        input TX_rst,
        input TX_Byte,
        output ROM_DV,
        output serial_i
    );

    // Clock and Reset handling inside the interface
    always @(posedge clk) begin
        // Include any clock-related logic if required
    end

    // Add any additional functionality required for your interface here
    assign gpioB_in = 32'b0;
endinterface
