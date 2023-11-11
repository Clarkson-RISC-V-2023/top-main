`include "uvm_macros.svh"
import uvm_pkg::*;
import top_params::*;  // Assuming you have a package for RISC-V specific classes and parameters

// Extend from uvm_test
class riscv_base_test extends uvm_test;
    `uvm_component_utils(riscv_base_test)

    // The UVM environment
    riscv_env env;

    // Constructor
    function new(string name = "riscv_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Build phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Create the environment
        `uvm_info(get_type_name(), $sformatf("Creating enviroment"), UVM_DEFAULT)
        env = riscv_env::type_id::create("env", this);
        // Configure the environment as needed
        // ...
    endfunction

    // End of elaboration phase
    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        // Additional setup can be done here if required
    endfunction

    // Run phase
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        `uvm_info(get_type_name(), $sformatf("HELLOOOOOO"), UVM_LOW)
        // Insert test sequences or operations here
        // ...
        phase.drop_objection(this);
    endtask

    // Report phase
    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        // Generate reports or additional logging
    endfunction

    // Other phases like extract_phase, check_phase, etc., can be added as per the requirement

endclass
