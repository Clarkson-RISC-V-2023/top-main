`include "uvm_macros.svh"
import uvm_pkg::*;
// import riscv_if::*; // Assuming you have an interface file for RISC-V

// Extend from uvm_env
class riscv_env extends uvm_env;

    // UVM factory registration macro
    `uvm_component_utils(riscv_env)

    // UVM components declaration
    top_agent top_agent_inst;
    // riscv_scoreboard scoreboard;
    // riscv_monitor monitor;

    // Interface
    virtual riscv_if vif;

    // Constructor
    function new(string name = "riscv_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Build phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        if (!uvm_config_db#(virtual riscv_if)::get(this, "", "top_vif", vif.TB)) begin
            `uvm_fatal("NOVIF", "Virtual interface must be set for riscv_env!")
        end

        // Create instances of agents and other components
        `uvm_info(get_type_name(), $sformatf("Creating agent"), UVM_LOW)
        top_agent_inst = top_agent::type_id::create("top_agent", this);
        // scoreboard = riscv_scoreboard::type_id::create("scoreboard", this);
        // monitor = riscv_monitor::type_id::create("monitor", this);

        // Configuration and connections
        // ... (configure and connect your agents, scoreboard, etc.)

    endfunction

    // Connect phase
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // Connect monitor to scoreboard
        // monitor.ap.connect(scoreboard.analysis_export);
        // Additional connections as needed
    endfunction

    // Configuration method (optional)
    // This can be used to set configurations from test
    virtual function void set_config();
        // Set configurations
        // ...
    endfunction

    // Other phases like run_phase, extract_phase, etc., can be added as per the requirement

endclass
