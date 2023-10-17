`include "uvm_macros.svh"
import uvm_pkg::*;

class gen_ialu_addi_seq extends uvm_sequence;
    `uvm_object_utils(gen_ialu_addi_seq)

    function new (string name = "DEFAULT ialu addi sequence");
        super.new(name);
    endfunction;

    ialu_addi_item item;

    virtual task body();
        `uvm_info(get_type_name(), $sformatf("Sending random addi instruction packet"), UVM_DEFAULT)
        item =  ialu_addi_item::type_id::create("initial addi ialu item");

        start_item(item);
        item.randomize();
        `uvm_info(get_type_name(), $sformatf("ialu_addi item has been randomized"), UVM_DEFAULT)
        `uvm_info(get_type_name(), item, UVM_DEFAULT);
        finish_item(itme);
    endtask
endclass