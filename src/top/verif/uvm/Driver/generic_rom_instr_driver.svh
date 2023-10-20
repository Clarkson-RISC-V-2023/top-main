`include "uvm_macros.svh"
import uvm_pkg::*;

class generic_rom_instr_driver extends uvm_driver #(uvm_sequence_item);
    `uvm_component_utils(generic_rom_instr_driver)

    virtual top_vif vif;

    function new (string name = "DEFAULT li driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual ram_if):: get(this, "", "top_vif", vif))
            `uvm_fatal(get_type_name(), "Could not get hold of vif...")
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item_port.get_next_item(req);
            vif.ROM_mem[req.id] = req.rom_instr;
            seq_item_port.item_done();
            `uvm_info(get_type_name(), $sformatf("Waiting for sequencer..."), UVM_LOW)
        end
    endtask
endclass