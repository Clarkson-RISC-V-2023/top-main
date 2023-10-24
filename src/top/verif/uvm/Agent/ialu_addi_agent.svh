`include "uvm_macros.svh"
import uvm_pkg::*;

class ialu_addi_agent extends uvm_agent;
    `uvm_component_utils(ialu_addi_agent)
    function new(string name = "DEFAULT RAM agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    generic_rom_instr_driver            d0;
    ialu_add_monitor                    m0;
    uvm_sequencer #(ialu_li_item)       s0;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        d0 = generic_rom_instr_driver::type_id::create("ADDi_DRIVER", this);
        m0 = ialu_add_monitor::type_id::create("ADDi_MONITOR", this);
        s0 = uvm_sequencer#(ialu_li_item)::type_id::create("ADDi_SEQUENCER", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        d0.seq_item_port.connect(s0.seq_item_export);
    endfunction
endclass