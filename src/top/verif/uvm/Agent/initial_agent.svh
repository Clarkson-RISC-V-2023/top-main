`include "uvm_macros.svh"
import uvm_pkg::*;

class initial_agent extends uvm_agent;
    `uvm_component_utils(initial_agent)
    function new(string name = "DEFAULT agent", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    initial_driver d0;
    uvm_sequencer #(ialu_add_item)    s0;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        d0 = initial_driver::type_id::create("DRIVER", this);
        s0 = uvm_sequencer#(ialu_add_item)::type_id::create("SEQUENCER", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        d0.seq_item_port.connect(s0.seq_item_export);
    endfunction
endclass