`include "uvm_macros.svh"
import uvm_pkg::*;

class i_type_item extends uvm_sequence_item;

    localparam reg_min = 0;
    localparam reg_max = 31;

    rand signed imm [11:0];
    rand bit rs1 [5:0];
    rand bit rs2 [5:0];
    rand bit rd  [5:0];

    bit opcode [6:0];
    bit func3  [2:0];

    constraint i_type_reg_range { rs1 inside [reg_min, reg_max]; rs2 inside [reg_min, reg_max]; rd inside [reg_min, reg_max]; };
    constraint i_type_imm_range { imm inside [-2047, 2047] };

endclass