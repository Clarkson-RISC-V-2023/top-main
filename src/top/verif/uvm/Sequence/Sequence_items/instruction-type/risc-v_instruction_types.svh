`include "uvm_macros.svh"
import uvm_pkg::*;

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

    rand bit rs1 [5:0];
    rand bit rs2 [5:0];
    rand bit rd  [5:0];

    bit opcode [6:0];
    bit func7  [6:0]
    bit func3  [2:0];

    bit rom_instr [31:0];

    constraint r_type_reg_range { rs1 inside [reg_min, reg_max]; rs2 inside [reg_min, reg_max]; rd inside [reg_min, reg_max]; };

    function void post_randomize();
        rom_instr[31:25] = func7;
        rom_instr[24:20]  = rs2;
        rom_instr[19:15] = rs1;
        rom_instr[14:12] = func3;
        rom_instr[11:7]  = rd;
        rom_instr[6:0]   = opcode 
    endfunction

endclass

/*
    i_type_item is the base sequence item for all i-type instructions, 
    extend this to generate more specific or constrained ojects
*/
virtual class i_type_item extends uvm_sequence_item;

    rand signed imm [11:0];
    rand bit rs1 [5:0];
    rand bit rd  [5:0];

    bit opcode [6:0];
    bit func3  [2:0];

    bit rom_instr [31:0];

    constraint i_type_reg_range { rs1 inside [reg_min, reg_max-1]; rd inside [reg_min, reg_max-1]; };
    constraint i_type_imm_range { imm inside [-2047, 2047] };

    function void post_randomize();
        rom_instr[31:20] = imm;
        rom_instr[19:15] = rs1;
        rom_instr[14:12] = func3;
        rom_instr[11:7]  = rd;
        rom_instr[6:0]   = opcode 
    endfunction

endclass

/*
    s_type_item is the base sequence item for all s-type instructions, 
    extend this to generate more specific or constrained ojects
*/
virtual class s_type_item extends uvm_sequence_item;

    rand signed imm [11:0];
    rand bit rs1 [5:0];
    rand bit rs2 [5:0]

    bit opcode [6:0];
    bit func3  [2:0];

    bit rom_instr [31:0];

    constraint s_type_reg_range { rs1 inside [reg_min, reg_max-1]; rs2 inside [reg_min, reg_max-1]; rd inside [reg_min, reg_max-1]; };
    constraint s_type_imm_range { imm inside [-2047, 2047] };

    function void post_randomize();
        rom_instr[31:25] = imm[11:5];
        rom_instr[24:20] = rs2;
        rom_instr[19:15] = rs1;
        rom_instr[14:12] = func3;
        rom_instr[11:7]  = imm[4:0];
        rom_instr[6:0]   = opcode 
    endfunction

endclass

/*
    b_type_item is the base sequence item for all b-type instructions, 
    extend this to generate more specific or constrained ojects
*/
virtual class b_type_item extends uvm_sequence_item;

    rand signed imm [12:0];
    rand bit rs1 [5:0];
    rand bit rs2 [5:0];

    bit opcode [6:0];
    bit func3  [2:0];

    bit rom_instr [31:0];

    constraint b_type_reg_range { rs1 inside [reg_min, reg_max-1]; rs2 inside [reg_min, reg_max-1]; };
    constraint b_type_imm_range { imm inside [-4095, 4095] };

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

    rand bit imm [31:12];
    rand bit rd  [5:0];

    bit opcode [6:0];

    bit rom_instr [31:0];

    constraint u_type_reg_range { rd inside [reg_min, reg_max-1]; };
    constraint u_type_imm_range { imm inside [12'h000, 12'hFFF] };

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

    rand signed imm [20:0];
    rand bit rd  [5:0];

    bit opcode [6:0];

    bit rom_instr [31:0];

    constraint j_type_reg_range { rd inside [reg_min, reg_max-1]; };
    constraint j_type_imm_range { imm inside [-1048575, 1048575] };

    function void post_randomize();
        rom_instr[31]    = imm[20];
        rom_instr[30:25] = imm[10:5];
        rom_instr[24:21] = imm[4:1];
        rom_instr[20]    = imm[11];
        rom_instr[19:15] = rd;
        rom_instr[6:0]   = opcode;
    endfunction

endclass
