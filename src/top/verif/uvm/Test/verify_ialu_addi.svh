// Create one li item, load it to ROM and verify addition 

`include "uvm_macros.svh"
import uvm_pkg::*;

class verify_ialu_addi extends uvm_test;
    `uvm_component_utils(verify_ialu_addi)
    function new(string name = "DEFAULT addi test", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    ialu_addi_env e0;
    virtual ialu_addi_if vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        e0 = ialu_addi_env::type_id::create("ialu_ADDi_ENVIROMENT", this);
        if (!uvm_config_db#(virtual ialu_addi_if)::get(this, "", "ialu_addi_vif", vif))
            `uvm_fatal(get_type_name(), "Did not get a hold for vif...")

            uvm_config_db#(virtual ialu_addi_if)::set(this, "e0.a0.*", "ialu_addi_vif", vif);
            `uvm_info(get_type_name(), "Succeed! Build Phase Complete...", UVM_LOW)
    endfunction

    virtual task run_phase(uvm_phase phase);
        gen_ialu_addi_seq seq = gen_ialu_addi_seq::type_id::create("SEQ ialu_ADDi", this);
        phase.raise_objection(this);
        
        seq.randomize();

        seq.start(e0.a0.s0);

        #200
        phase.drop_objection(this);
    endtask
    
endclass 