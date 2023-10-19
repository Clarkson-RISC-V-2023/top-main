`include "uvm_macros.svh"
import uvm_pkg::*;

class top_driver_rom_instr extends uvm_driver #(li_item);
    `uvm_component_utils(top_driver)

    ialu_addi_item item;
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
            seq_item_port.get_next_item(item);

            drive_item(item);
            seq_item_port.item_done();
            `uvm_info(get_type_name(), $sformatf("Waiting for sequencer..."), UVM_LOW)
        end
    endtask

    // TODO update addi items to have a member that contains the whole 32 bit instruction
    virtual task drive_item(ram_packet_item item);
        vif.reg_file_rs1    = item.addr;
        vif.reg_file_rs2    = item.wdata;
        vif.mem_block_en    = item.mem_block_en;
        vif.reg_file_rd     = item.wr_en;
        vif.reg_file_din    = item.rdata;
        vif.reg_file_rd1    = // TODO how to handle this
        vif.reg_file_rd2    = // TODO how to handle this
        vif.reg_file_we     = item.regs_wr_en
        @ (posedge vif.clk);
    endtask
endclass