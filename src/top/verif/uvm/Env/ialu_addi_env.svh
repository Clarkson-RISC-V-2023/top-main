`include "uvm_macros.svh"
import uvm_pkg::*;

class ialu_addi_env extends uvm_env;
    `uvm_component_utils(ialu_addi_env)
    function new(string name = "DEFAULT ram_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    ialu_addi_agent      a0;
    ialu_add_scoreboard  sb0;
    virtual top_vif      vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        a0  = ialu_addi_agent::type_id::create("ialu_ADDi_AGENT", this);
        sb0 = ialu_add_scoreboard::type_id::create("ialu_ADDi_SCOREBOARD", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        a0.m0.mon_analysis_port.connect(sb0.m_analysis_imp);
    endfunction
endclass