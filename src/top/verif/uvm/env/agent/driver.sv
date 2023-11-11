`include "uvm_macros.svh"
import uvm_pkg::*;

import top_params::*;
class driver extends uvm_driver #(riscv_instr_item);
    `uvm_component_utils(driver)

    riscv_instr_item item;
    virtual riscv_if vif;

    function new (string name = "DEFAULT top driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual riscv_if):: get(this, "", "top_vif", vif))
            `uvm_fatal(get_type_name(), "Could not get hold of vif...")
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        initial_reset();

        forever begin
            `uvm_info(get_type_name(), $sformatf("Hello from driver..."), UVM_LOW)
            seq_item_port.get_next_item(item);
            item.print();
            drive_item_instr(item);

            // Uncoment for debug
            // if (item.wr_en)
            //     `uvm_info(get_type_name(), $sformatf("Waiting 0x%0h @ 0x%0h...", item.wdata, item.addr), UVM_LOW)
            // else
            //     `uvm_info(get_type_name(), $sformatf("Reading @ 0x%0h...", item.addr), UVM_LOW)
            // drive_item(item);
            seq_item_port.item_done();
            // `uvm_info(get_type_name(), $sformatf("Waiting for sequencer..."), UVM_LOW)
        end
    endtask

    virtual function void extract_phase (uvm_phase phase);
        super.extract_phase(phase);
    endfunction;

    // virtual task drive_item(ram_packet_item item);
    //     vif.addr = item.addr;
    //     vif.wdata = item.wdata;
    //     vif.mem_block_en = item.mem_block_en;
    //     vif.wr_en = item.wr_en;
    //     vif.rdata = item.rdata;
    //     @ (negedge vif.clk);
    // endtask

    virtual task clk_delay(int delay);
        for (int i = 1; i <= delay; i = i + 1) begin
            @ (posedge vif.TB.clk);
        end
    endtask

    virtual task initial_reset();
        vif.TB.reset_n = 1'b0;
        vif.TB.serial_i = 1'b0;
        vif.TB.uvm_driver_en = 'b0;
        clk_delay(16);
        $display("Programing mode.....");
        vif.TB.reset_n = 1'b1;
        clk_delay(4);
        vif.TB.reset_n = 1'b0;

    endtask

    virtual task drive_item_instr(riscv_instr_item item);
        for (int i = 32 - 8; i >= 0; i -= 8) begin
            vif.TB.uvm_driver_en = 1'b1;
            vif.TB.TX_Byte = item.instruction[i +: 8]; // Extract 8 bits starting from index i
            clk_delay(1); // TX Idle to TX_START_BIT
            vif.TB.uvm_driver_en = 1'b0;
            clk_delay(1); // Sends start bit

            clk_delay(15*ROM_BAUD_FACTOR);
        end
    clk_delay(3);
    endtask

    virtual task run_processor();
        vif.TB.reset_n = 1'b1;
        clk_delay(1000);
    endtask


endclass