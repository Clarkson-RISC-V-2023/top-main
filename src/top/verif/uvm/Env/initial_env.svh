`include "uvm_macros.svh"
import uvm_pkg::*;

class initial_env extends uvm_env;
    `uvm_component_utils(initial_env)
    function new(string name = "DEFAULT ram_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    initial_agent a0;
    virtual top_vif vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        a0 = initial_agent::type_id::create("AGENT", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
    endfunction
endclass