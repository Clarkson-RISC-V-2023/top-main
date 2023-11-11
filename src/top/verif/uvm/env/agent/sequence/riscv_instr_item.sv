`include "uvm_macros.svh"
import uvm_pkg::*;

class riscv_instr_item extends uvm_sequence_item;

    // Instruction fields
    rand bit [31:0] instruction;

    // UVM factory registration
    `uvm_object_utils_begin(riscv_instr_item)
        `uvm_field_int(instruction, UVM_DEFAULT)
    `uvm_object_utils_end

    // Constructor
    function new(string name = "riscv_instr_item");
        super.new(name);
    endfunction

    // Member function to easily set instruction
    function void set_instruction(bit [31:0] instr);
        instruction = instr;
    endfunction

endclass
