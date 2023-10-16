`include "uvm_macros.svh"
import uvm_pkg::*;

/*
    An Add operation takes multiple steps
    - lw to rs1
        - RAM needs to be preloaded (ADDI)
    - lw to ts2
        - RAM needs to be preloaded (ADDI)
    - Perform operation in ialu
    - Sequencer will verify operation
*/

// TODO Initial state only generates 1 addition instruction
class gen_ialu_add_seq extends uvm_sequence;
    `uvm_object_utils(gen_ialu_add_seq)

    function new (string name = "DEFAULT ialu add sequence");
        super.new(name);
    endfunction;

    ialu_add_item add_item;

    virtual task body();
        `uvm_info(get_type_name(), $sformatf("Sending random addition packet"), UVM_DEFAULT)

        add_item = ialu_add_item::type_id::create("Initial add ialu item");

        start_item(add_item);
        add_item.randomize()
        finish_item(add_item);
    endtask
endclass