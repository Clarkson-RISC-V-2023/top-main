`include "uvm_macros.svh"
import uvm_pkg::*;

// Extend from uvm_test
class initial_test extends uvm_test;

    // The UVM_COMPONENT_UTILS macro is used for factory registration
    `uvm_component_utils(initial_test)

    // Declare any component handles or variables here
    // e.g., uvm_sequence, uvm_env, etc.
    initial_env e0;
    virtual top_vif vif;

    // Constructor
    function new(string name = "initial_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Build Phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        e0 = initial_env::type_id::create("Initial_ENVIROMENT", this);
        if (!uvm_config_db#(virtual top_vif)::get(this, "", "top_vif", vif))
            `uvm_fatal(get_type_name(), "Did not get a hold for vif...")

            uvm_config_db#(virtual top_vif)::set(this, "e0.a0.*", "top_vif", vif);
            `uvm_info(get_type_name(), "Succeed! Build Phase Complete...", UVM_LOW)
    endfunction

    // Connect Phase
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), "Succeed! Connect Phase Complete...", UVM_LOW)
        // Connect components (if required)
    endfunction

    // Run Phase
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        // Main test logic goes here
        // e.g., start sequences, control simulation flow
        // initial_sequence seq = initial_sequence::type_id::create("SEQ Test", this);
        // phase.raise_objection(this);

        // seq.randomize();
        // seq.start(e0.a0.s0);

        // #200
        // phase.drop_objection(this);
    endtask

    virtual function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
        // Your extraction logic here
    endfunction

    virtual function void check_phase(uvm_phase phase);
        super.check_phase(phase);
        // Your checking logic here
    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        // Your reporting logic here
    endfunction

    virtual function void final_phase(uvm_phase phase);
        super.final_phase(phase);
        // Your finalization logic here
    endfunction

endclass
