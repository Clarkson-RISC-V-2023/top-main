`include "uvm_macros.svh"
import uvm_pkg::*;

class top_driver_li extends uvm_driver #(li_item);
    `uvm_component_utils(top_driver)

    ialu_addi_item item;
    virtual top_vif vif;

    function new (string name = "DEFAULT RAM driver", uvm_component parent=null);
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
            // `uvm_info(get_type_name(), $sformatf("Waiting for sequencer..."), UVM_LOW)
        end
    endtask

    virtual task drive_item(ram_packet_item item);
        vif.reg_file_rs1 = item.addr;
        vif.wdata = item.wdata;
        vif.mem_block_en = item.mem_block_en;
        vif.wr_en = item.wr_en;
        vif.rdata = item.rdata;
        @ (posedge vif.clk);
    endtask
endclass