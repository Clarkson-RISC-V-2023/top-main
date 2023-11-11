`include "uvm_macros.svh"
import uvm_pkg::*;
import top_params::*;

interface riscv_if(input wire clk, reset_n);

    // Signal declarations
    wire serial_i;
    reg programming_mode;

    reg [TOP_DATA_WIDTH-1:0] gpioA_out;
    wire [TOP_DATA_WIDTH-1:0] gpioB_in;

    // Add additional signals as per your requirement

    // Modport for the DUT side
    modport DUT (
        input clk, reset_n, serial_i, gpioB_in,
        output programming_mode, gpioA_out
    );


    // Modport for the Testbench side
    modport TB (
        output clk, reset_n, serial_i, gpioB_in,
        input programming_mode, gpioA_out
        // Add additional signals as per your requirement
    );

    // Clock and Reset handling inside the interface
    always @(posedge clk) begin
        // Include any clock-related logic if required
    end

    // Add any additional functionality required for your interface here

endinterface
