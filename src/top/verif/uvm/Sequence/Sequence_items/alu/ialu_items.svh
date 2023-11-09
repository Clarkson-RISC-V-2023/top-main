import uvm_pkg::*;
`include "uvm_macros.svh"

// Add

class ialu_add_item extends uvm_sequence_item;

    rand bit [$clog2(10)-1:0]    addr;
    rand bit [10-1:0]               wdata;
    rand bit [10-1:0]        mem_block_en;
    rand bit                                wr_en;
    bit      [10-1:0]               rdata;

    constraint ram_item_addr { addr inside {[0:10-1]}; };

    // Use macro to register class with factory
    `uvm_object_utils_begin(ialu_add_item)
        `uvm_field_int(addr, UVM_DEFAULT)
        `uvm_field_int(wdata, UVM_DEFAULT)
        `uvm_field_int(rdata, UVM_DEFAULT)
        `uvm_field_int(mem_block_en, UVM_DEFAULT)
        `uvm_field_int(wr_en, UVM_DEFAULT)
    `uvm_object_utils_end

    function new (string name = "DEFAULT ram_packet_item");
        super.new(name);
    endfunction

    virtual function string convert2string();
        return $sformatf("addr=0x%0h - wdata=0x%0h - rdata=0x%0h - wr=%0d - mem_block_en=0x%h", addr, wdata, rdata, wr_en, mem_block_en);
    endfunction

    
    // `uvm_object_utils(ialu_add_item)

    // function new(string name = "add_instruction");
    //     super.new(name);
    // endfunction

    // // Override post_randomize if needed for specific behavior
    // function void post_randomize();
    //     super.post_randomize();
        
    //     // Set specific values for the ADD instruction
    //     this.opcode = 7'b0110011;
    //     this.func7 = 7'b0000000;
    //     this.func3 = 3'b000;
    // endfunction

endclass


// // Add Imediate
// class ialu_addi_item extends i_type_item;

//     // This will be used to identify whych memory address this item was assigned to
//     int id;

//     // Register data in, to be used by monitor
//     bit [31:0] din;
    
//     // Item Constructor
//     function new(string name = "DEFAULT_ialu_add_item", int id = 0);
//         super.new(name);
//         opcode = 7'b0010011;
//         func3 = 3'b000;
//         this.id = id;
//     endfunction : new

//     `uvm_object_utils_begin(ialu_addi_item)
//         `uvm_field_int(opcode, UVM_DEFAULT)
//         `uvm_field_int(func3, UVM_DEFAULT)
//         `uvm_field_int(rs1, UVM_DEFAULT)
//         `uvm_field_int(rd, UVM_DEFAULT)
//         `uvm_field_int(imm, UVM_DEFAULT)
//         `uvm_field_int(din, UVM_DEFAULT)
//     `uvm_object_utils_end

// endclass

// // Load imediate
// class ialu_li_item extends ialu_addi_item;

//     constraint li_rs1_is_always_zero { rs1 == 6'b000000; };

//     // Item Constructor
//     function new(string name = "DEFAULT_ialu_li_item", int id = 0);
//         super.new(name, id);
//         rs1   = 6'b000000;
//     endfunction : new

//     `uvm_object_utils_begin(ialu_li_item)
//         `uvm_field_int(opcode, UVM_DEFAULT)
//         `uvm_field_int(func3, UVM_DEFAULT)
//         `uvm_field_int(rs1, UVM_DEFAULT)
//         `uvm_field_int(din, UVM_DEFAULT)
//         `uvm_field_int(rd, UVM_DEFAULT)
//         `uvm_field_int(imm, UVM_DEFAULT)
//     `uvm_object_utils_end
// endclass