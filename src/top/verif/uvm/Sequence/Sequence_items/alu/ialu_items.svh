// Add
class ralu_add_item extends r_type_item;

    // This will be used to identify which memory address this item was assigned to
    int id;

    // Item Constructor
    function new(string name = "DEFAULT_ialu_add_item", int id = 0);
        super.new(name);
        opcode = 7'b0110011; // opcode for R-type instructions (you may need to verify)
        func3  = 3'b000;     // func3 for ADD instruction (you may need to verify)
        func7  = 7'b0000000; // func7 for ADD instruction (you may need to verify)
        this.id = id;
    endfunction : new

    `uvm_object_utils_begin(ralu_add_item)
        `uvm_field_int(opcode, UVM_DEFAULT)
        `uvm_field_int(func3, UVM_DEFAULT)
        `uvm_field_int(func7, UVM_DEFAULT)
        `uvm_field_int(rs1, UVM_DEFAULT)
        `uvm_field_int(rs2, UVM_DEFAULT)
        `uvm_field_int(rd, UVM_DEFAULT)
    `uvm_object_utils_end

endclass


// Add Imediate
class ialu_addi_item extends i_type_item;

    // This will be used to identify whych memory address this item was assigned to
    int id;

    // Item Constructor
    function new(string name = "DEFAULT_ialu_add_item", int id = 0);
        super.new(name);
        opcode = 7'b0010011;
        func3 = 3'b000;
        this.id = id;
    endfunction : new

    `uvm_object_utils_begin(ialu_addi_item)
        `uvm_field_int(opcode, UVM_DEFAULT)
        `uvm_field_int(func3, UVM_DEFAULT)
        `uvm_field_int(rs1, UVM_DEFAULT)
        `uvm_field_int(rs2, UVM_DEFAULT)
        `uvm_field_int(rd, UVM_DEFAULT)
        `uvm_field_int(imm, UVM_DEFAULT)
        `uvm_field_int(regs_wr_en, UVM_DEFAULT)
    'uvm_object_utils_end

endclass

// Load imediate
class li_item extends ialu_addi_item;

    constraint li_rs1_is_always_zero { rs1 == 6'b000000; };
    
    // Item Constructor
    function new(string name = "DEFAULT_li_item", int id = 0);
        super.new(name, id);
        rs1   = 6'b000000;
    endfunction : new

    `uvm_object_utils_begin(li_item)
        `uvm_field_int(opcode, UVM_DEFAULT)
        `uvm_field_int(func3, UVM_DEFAULT)
        `uvm_field_int(rs1, UVM_DEFAULT)
        `uvm_field_int(rs2, UVM_DEFAULT)
        `uvm_field_int(rd, UVM_DEFAULT)
        `uvm_field_int(imm, UVM_DEFAULT)
        `uvm_field_int(regs_wr_en, UVM_DEFAULT)
    `uvm_object_utils_end
endclass