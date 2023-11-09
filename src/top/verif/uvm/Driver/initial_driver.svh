`include "uvm_macros.svh"
import uvm_pkg::*;

class initial_driver extends uvm_driver #(ialu_add_item);
    `uvm_component_utils(initial_driver)
    
    ialu_add_item item;
    virtual top_vif vif;

    function new (string name = "DEFAULT driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual top_vif):: get(this, "", "top_vif", vif))
            `uvm_fatal(get_type_name(), "Could not get hold of vif...")
    endfunction

    // virtual task run_phase(uvm_phase phase);
    //     super.run_phase(phase);
    //     forever begin
    //         seq_item_port.get_next_item(item);

    //         seq_item_port.item_done();
    //         `uvm_info(get_type_name(), $sformatf("Waiting for sequencer..."), UVM_LOW)
    //     end
    // endtask
endclass