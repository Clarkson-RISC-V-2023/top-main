`include "uvm_macros.svh"
import uvm_pkg::*;

class initial_sequence extends uvm_sequence;
    `uvm_component_utils(initial_sequence)
    function new(string name = "DEFAULT initial seq");
        super.new(name);
    endfunction

    ialu_add_item item;

    virtual task body();
        `uvm_info(get_type_name(), $sformatf("Started sequence"), UVM_DEFAULT)
        
        item =  ialu_add_item::type_id::create("TEST1");
        start_item(item);
        item.randomize();
        itme.print();
        finish_item(item);
    endtask
endclass