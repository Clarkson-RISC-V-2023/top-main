`include "uvm_macros.svh"
import uvm_pkg::*;

// TODO parametrize this
interface top_vif (input bit clk);

    // Register file inputs
    logic [5:0] reg_file_rs1;
    logic [5:0] reg_file_rs2;
    logic [5:0] reg_file_rd;
    logic [31:0] reg_file_din;
    
    // Register file outputs
    logic [31:0] reg_file_rd1;
    logic [31:0] reg_file_rd2;

    // Read Enable Signal
    logic reg_file_we;

    // ROM out instr
    logic [8191:0] ROM_mem [31:0]

    // Memory Mapped I/O
    logic [31:0] gpioA;
    logic [31:0] gpioB;
endinterface