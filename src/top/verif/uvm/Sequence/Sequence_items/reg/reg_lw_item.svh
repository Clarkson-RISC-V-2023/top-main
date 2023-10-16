`include "uvm_macros.svh"
import uvm_pkg::*;

class reg_lw_item extends uvm_sequence_item;

    // Constant func OPCODES
    bit func3 [2:0] = 3'b010;
    bit opcode[6:0] = 7'b0000011;

    // Constrained random REG addresses
    rand bit rs1 [5:0];
    rand bit rd  [5:0];

    constraint reg_lw_rs1_range { rs1 inside {[5, 7], [8, 9], [18, 27], [28, 31]}; };
    constraint reg_lw_rsd_range { rsd inside {[5, 7], [8, 9], [18, 27], [28, 31]}; };

    // Constrained random REG addresses offset
    rand unsigned [11:0];
    // TODO is this lw offset right
    constraint reg_lw_imm_offset { imm inside [-2048, 2048] };

    // Register with UVM Factory
    `uvm_object_utils_begin(reg_lw_item)
        `uvm_field_int(func3, UVM_DEFAULT)
        `uvm_field_int(rs1, UVM_DEFAULT)
        `uvm_field_int(rd, UVM_DEFAULT)
        `uvm_field_int(imm, UVM_DEFAULT)
    `uvm_object_utils_end

    // Declare Initialization and beheavior functions:
    function new (string name = "DEFAULT reg lw");
        super.new(name);
    endfunction
endclass