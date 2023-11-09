`include "uvm_macros.svh"
import uvm_pkg::*;

import ram_params::*;

module tb_uvm_top;

    reg clk;

    top_vif vif (
        .clk(clk)
    );

    top dut_top (
        .clk_i(clk),
        .reset_n(vif.reset_n),
        .serial_i(vif.serial),
        .programming_mode_o(vif.programming_mode),
        .gpioA_out(vif.gpioA),
        .gpioB_in(vif.gpioB)
    );

    always #10 clk = ~clk;
    initial begin
        clk <= 0;

        uvm_config_db #(virtual top_vif)::set(uvm_root::get(), "*", "top_vif", vif);

        run_test("initial_test");
    end
        
endmodule

/*
1. Build Phase: In this phase, objects are constructed, and the configuration is set. This includes instantiation of UVM components like agents, drivers, monitors, etc.

2. Connect Phase: Connections between UVM components are established in this phase. It involves setting up TLM connections, interfaces, and other communication pathways.

3. End of Elaboration Phase: This phase is used for any final checks and modifications before simulation begins. It's typically used for setting up configurations that need to be done after the build phase but before the simulation starts.

4. Start of Simulation Phase: This phase signifies the beginning of the simulation. It's often used for tasks that need to be done right before the simulation runs, such as final logging or reporting setups.

5. Run Phase: The most critical phase, where the main part of the simulation takes place. This includes driving stimulus into the DUT, monitoring outputs, checking responses, and collecting coverage.

6. Extract Phase: Here, data is extracted from the DUT or the testbench for analysis. This could involve capturing performance metrics, internal states, or other relevant information.

7. Check Phase: In this phase, the extracted data is checked against expected values or models. This is crucial for identifying discrepancies and verifying the DUT's functionality.

8. Report Phase: The results of the simulation, including pass/fail status, coverage reports, and other metrics, are compiled and reported in this phase.

9. Final Phase: This is the last phase of the UVM testbench, where cleanup and final reporting are performed. It's used for closing files, logging final messages, and releasing resources.
*/