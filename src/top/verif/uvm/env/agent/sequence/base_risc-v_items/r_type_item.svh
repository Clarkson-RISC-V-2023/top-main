`include "uvm_macros.svh"
import uvm_pkg::*;

class r_type_item extends uvm_sequence_item;

    `uvm_object_utils(r_type_item)

    rand bit [4:0] rs1;
    rand bit [4:0] rs2;
    rand bit [4:0] rd;

    bit [6:0] opcode;
    bit [6:0] func7;
    bit [2:0] func3;

    bit [31:0] rom_instr;

    constraint r_type_reg_range { 
        rs1 inside {[0 : 31]}; 
        rs2 inside {[0 : 31]}; 
        rd inside  {[1 : 31]}; // Excluding x0
        rs1 != rs2 && rs2 != rd && rs1 != rd;
    };

    function new(string name = "r_type_item");
        super.new(name);
    endfunction

    virtual function void post_randomize();
        super.post_randomize();
        rom_instr[31:25] = func7;
        rom_instr[24:20]  = rs2;
        rom_instr[19:15] = rs1;
        rom_instr[14:12] = func3;
        rom_instr[11:7]  = rd;
        rom_instr[6:0]   = opcode;
    endfunction

    // Example of a pure virtual function
    // virtual function void additional_behavior() = 0;

endclass
