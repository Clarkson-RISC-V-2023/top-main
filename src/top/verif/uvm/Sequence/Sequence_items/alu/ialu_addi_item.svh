class ialu_addi_item extends i_type_item;

    // TODO modify it to allow read and writes
    bit regs_wr_en = 1'b1;

    // Item Constructor
    function new(string name = "DEFAULT_ialu_add_item");
        super.new(name);
        opcode = 6'b0010011;
        func3 = 3'b000;
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
    function new(string name = "DEFAULT_li_item");
        super.new(name);
        opcode = 6'b0010011;
        func3 = 3'b000;
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