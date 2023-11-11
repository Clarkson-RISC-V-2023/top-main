`include "uvm_macros.svh"
import uvm_pkg::*;

class riscv_basic_sequence extends uvm_sequence #(riscv_instr_item);

    // UVM factory registration
    `uvm_object_utils(riscv_basic_sequence)

    // Constructor
    function new(string name = "riscv_basic_sequence");
        super.new(name);
    endfunction

    // Body of the sequence
    virtual task body();
        riscv_instr_item item;
        
        `uvm_create(item)
        
        // Example: Testing a simple ADD instruction
        item.set_instruction(32'h00008033); // ADD x0, x1, x0
        `uvm_send(item)

        // Add more instructions as needed
        // ...

        for (int i = 0; i < 3; i++) begin
            string seq_name = $sformatf("Random Sequence #%d", i);
            `uvm_create(item)
            item.randomize();
            `uvm_send(item)
        end

        `uvm_info(get_type_name(), "Basic sequence executed.", UVM_LOW)
    endtask

endclass
