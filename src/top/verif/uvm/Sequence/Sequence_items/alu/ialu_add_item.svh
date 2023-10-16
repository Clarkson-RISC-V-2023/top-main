`include "uvm_macros.svh"
import uvm_pkg::*;

class ialu_add_item extends uvm_sequence_item;

    // Constant func OPCODES
    bit opcode[6:0] = 7'b0110011; 
    bit func7 [5:0] = 6'b00000;
    bit func3 [2:0] = 3'b000;

    // Constrained random REG addresses
    rand bit rs1 [5:0];
    rand bit rs2 [5:0];
    rand bit rd  [5:0];

    // Constraint the random reg address to be in the 'temporary registers', rs1 should not be the same as rs2 
    // TODO can rs1 be the same as rs2?
    constraint ialu_add_rs1_range { rs1 ~= rs2; rs1 inside {[5, 7], [28, 31]}; };
    constraint ialu_add_rs2_range { rs2 ~= rs1; rs2 inside {[5, 7], [28, 31]};};
    constraint ialu_add_rsd_range { rd inside {[5, 7], [28, 31]}; };

    // Add arguments that will be loaded to the register
    // TODO what happens if addition ends in overflow?
    rand bit rs1_val [31:0];
    rand bit rs2_val [31:0];
    bit rd_expected  [31:0];

    function void post_randomize();
        rd_expected = rs1_val + rs2_val;
    endfunction

    // Temporary constraint to prevent overloads
    constraint temporary_rs1_rs2_values { rs1_val+rs2_val <= 32'hFFFF_FFFF; };

    // Register with UVM Factory
    `uvm_object_utils_begin(ialu_add_item)
        `uvm_field_int(func7, UVM_DEFAULT)
        `uvm_field_int(func3, UVM_DEFAULT)
        `uvm_field_int(rs1, UVM_DEFAULT)
        `uvm_field_int(rs2, UVM_DEFAULT)
        `uvm_field_int(rd, UVM_DEFAULT)
        `uvm_field_int(rs1_val, UVM_DEFAULT)
        `uvm_field_int(rs2_val, UVM_DEFAULT)
        `uvm_field_int(rd_expected, UVM_DEFAULT)
    `uvm_object_utils_end

    // Declare Initialization and beheavior functions:
    function new (string name = "DEFAULT ialu add");
        super.new(name);
    endfunction

    function string item_info();
        return $sformatf("func7: 6b%5b - func3: 6b%5b \n\t\trs1 addr : %2d - data : %8h\n\t\trs2 addr : %2d - data : %8h\n\t\trd exp addr : %2d - data : %8h", func7, func3, rs1, rs1_val, rs2, rs2_val, rd, rd_expected);
    endfunction
endclass