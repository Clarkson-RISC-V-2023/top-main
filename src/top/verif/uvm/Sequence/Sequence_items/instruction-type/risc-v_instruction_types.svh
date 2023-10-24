`include "uvm_macros.svh"
import uvm_pkg::*;
import uvm_params::*;

// virtual stands for abstract class

/*
    This file contais 6 abstract classes:
    - r_type_item
    - i_type_item
    - s_type_item
    - b_type_item
    - u_type_item
    - j_type_item

    This classes can be expanded and used as building blocks 
    for RISC-V instructions like ADD, ADDi, SW....
*/

/*
    r_type_item is the base sequence item for all r-type instructions, 
    extend this to generate more specific or constrained ojects
*/
virtual class r_type_item extends uvm_sequence_item;

    rand bit [5:0] rs1;
    rand bit [5:0] rs2;
    rand bit [5:0] rd;

    bit [6:0] opcode;
    bit [6:0] func7;
    bit [2:0] func3;

    bit [31:0] rom_instr ;

    constraint r_type_reg_range { 
        rs1 inside {[0 : 31]}; 
        rs2 inside {[0 : 31]}; 
        rd inside  {[1 : 31]}; 
        rs1 != rs2 && rs2 != rd && rs1 != rd;
    };

    function void post_randomize();
        rom_instr[31:25] = func7;
        rom_instr[24:20]  = rs2;
        rom_instr[19:15] = rs1;
        rom_instr[14:12] = func3;
        rom_instr[11:7]  = rd;
        rom_instr[6:0]   = opcode;
    endfunction

endclass

/*
    i_type_item is the base sequence item for all i-type instructions, 
    extend this to generate more specific or constrained ojects
*/
virtual class i_type_item extends uvm_sequence_item;

    rand bit    [11:0] imm;
    rand bit    [5:0]  rs1;
    rand bit    [5:0]  rd;

    bit [6:0] opcode;
    bit [2:0] func3;

    bit [31:0]rom_instr;

    constraint i_type_reg_range { rs1 inside {[0 : 31]}; rd inside {[1 : 31]}; rs1 != rd; };
    constraint i_type_imm_range { imm inside {[0 : 2047]}; };

    function void post_randomize();
        rom_instr[31:20] = imm;
        rom_instr[19:15] = rs1;
        rom_instr[14:12] = func3;
        rom_instr[11:7]  = rd;
        rom_instr[6:0]   = opcode;
    endfunction

endclass

/*
    s_type_item is the base sequence item for all s-type instructions, 
    extend this to generate more specific or constrained ojects
*/
virtual class s_type_item extends uvm_sequence_item;

    rand bit    [11:0] imm;
    rand bit    [5:0] rs1;
    rand bit    [5:0] rs2;

    bit         [6:0] opcode;
    bit         [2:0] func3;

    bit         [31:0] rom_instr;

    constraint s_type_reg_range { rs1 inside {[0 : 31]}; rs2 inside {[0 : 31]}; };
    constraint s_type_imm_range { imm inside {[0 : 2047]}; };

    function void post_randomize();
        rom_instr[31:25] = imm[11:5];
        rom_instr[24:20] = rs2;
        rom_instr[19:15] = rs1;
        rom_instr[14:12] = func3;
        rom_instr[11:7]  = imm[4:0];
        rom_instr[6:0]   = opcode;
    endfunction

endclass

/*
    b_type_item is the base sequence item for all b-type instructions, 
    extend this to generate more specific or constrained ojects
*/
virtual class b_type_item extends uvm_sequence_item;

    rand bit    [12:0] imm;
    rand bit    [5:0]  rs1;
    rand bit    [5:0]  rs2;

    bit         [6:0] opcode;
    bit         [2:0] func3;

    bit         [31:0] rom_instr;

    constraint b_type_reg_range { rs1 inside {[0 : 31]}; rs2 inside {[0 : 31]}; };
    constraint b_type_imm_range { imm inside {[0 : 4095]}; };

    function void post_randomize();
        rom_instr[31]    = imm[12];
        rom_instr[30:25] = imm[10:5];
        rom_instr[24:20] = rs2;
        rom_instr[19:15] = rs1;
        rom_instr[14:12] = func3;
        rom_instr[11]    = imm[4];
        rom_instr[10:7]  = imm[3:1];
        rom_instr[6:0]   = opcode;
    endfunction

endclass

/*
    u_type_item is the base sequence item for all u-type instructions, 
    extend this to generate more specific or constrained ojects
*/
virtual class u_type_item extends uvm_sequence_item;

    rand bit    [31:12]imm;
    rand bit    [5:0]  rd;

    bit         [6:0]  opcode;
    bit         [31:0] rom_instr;

    constraint u_type_reg_range { rd inside {[1 : 31]}; };
    constraint u_type_imm_range { imm inside {[12'h000 : 12'hFFF]}; };

    function void post_randomize();
        rom_instr[31:12] = imm;
        rom_instr[11:7]  = rd;
        rom_instr[6:0]   = opcode;
    endfunction

endclass

/*
    j_type_item is the base sequence item for all j-type instructions, 
    extend this to generate more specific or constrained ojects
*/
virtual class j_type_item extends uvm_sequence_item;

    rand bit    [20:0] imm;
    rand bit    [5:0]  rd;

    bit         [6:0]  opcode;
    bit         [31:0] rom_instr;

    constraint j_type_reg_range { rd inside {[1 : 31]}; };
    constraint j_type_imm_range { imm inside {[0 : 1048575]}; };

    function void post_randomize();
        rom_instr[31]    = imm[20];
        rom_instr[30:25] = imm[10:5];
        rom_instr[24:21] = imm[4:1];
        rom_instr[20]    = imm[11];
        rom_instr[19:15] = rd;
        rom_instr[6:0]   = opcode;
    endfunction

endclass
