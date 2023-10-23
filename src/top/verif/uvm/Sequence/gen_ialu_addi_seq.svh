`include "uvm_macros.svh"
import uvm_pkg::*;

// TODO pass id parameter to sequece items

class gen_ialu_add_seq extends uvm_sequence;
    `uvm_object_utils(gen_ialu_add_seq)

    function new (string name = "DEFAULT ialu add sequence");
        super.new(name);
    endfunction;

    ialu_add_item add_item;

    virtual task body();
        add_item = ialu_add_item::type_id::create("Initial add ialu item");

        start_item(add_item);
        add_item.randomize()
        `uvm_info(get_type_name(), $sformatf("ialu_add item has been created and randomized"), UVM_DEFAULT)
        add_item.print();
        finish_item(add_item);
    endtask
endclass

class gen_ialu_addi_seq extends uvm_sequence;
    `uvm_object_utils(gen_ialu_addi_seq)

    function new (string name = "DEFAULT ialu addi sequence");
        super.new(name);
    endfunction;

    ialu_addi_item item;

    virtual task body();
        item =  ialu_addi_item::type_id::create("initial addi ialu item");

        start_item(item);
        item.randomize();
        `uvm_info(get_type_name(), $sformatf("ialu_addi item has been created and randomized"), UVM_DEFAULT)
        item.print();
        finish_item(itme);
    endtask
endclass

class gen_li_seq extends uvm_sequence;
    `uvm_object_utils(gen_ialu_addi_seq)

    function new (string name = "DEFAULT li sequence");
        super.new(name);
    endfunction;

    ialu_addi_item item;

    virtual task body();
        item =  ialu_li_item::type_id::create("initial li item");

        start_item(item);
        item.randomize();
        `uvm_info(get_type_name(), $sformatf("li (ialu_addi) item has been created and randomized"), UVM_DEFAULT)
        item.print();
        finish_item(itme);
    endtask
endclass