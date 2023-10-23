`timescale 1ns/1ps
`define ROM_Inst_INIT_PATH "src/top/mem_file/instruction.bin"
`define ROM_A_INIT_PATH "src/top/mem_file/a.hex"
`define ROM_B_INIT_PATH "src/top/mem_file/b.hex"

import top_params::*;

module top #(
    input wire clk,
    input wire reset_n,
    output reg [DATA_WIDTH-1:0] gpioA_out,
    output reg [DATA_WIDTH-1:0] gpioB_out
);
    // Types
    `define R_TYPE 3'b000
    `define I_TYPE 3'b001
    `define S_TYPE 3'b010
    `define B_TYPE 3'b011
    `define U_TYPE 3'b100
    `define J_TYPE 3'b101

     //ALUSelect
    `define SEL_CORDIC  2'b11
    `define SEL_FALU    2'b10
    `define SEL_IALU    2'b01
    `define SEL_NONE    2'b00

 //TODO: Need to add cordic Signals, need to instantiate FALU and add MUX stuff
 //TODO: change reg file inputs to be 6 bits when cordic and falu stuff is added
    wire we, mwe, overwrite, jump, load, AUIPC_sig, f_d1, f_d2, f_rd;    //alu_status_i, alu_status_o;
    wire [REG_FILE_WIDTH-1:0] r1, r2, rd;
    wire [OUT_BUS_WIDTH-1:0] d1, d2, lsu_d_out, ialu_OUT, jump_OUT, branch_out, i_TYPE_EXT, s_TYPE_EXT, u_TYPE_EXT, falu_OUT;
    reg [OUT_BUS_WIDTH-1:0] load_mux, WriteBack_data, IALU_IN1, IALU_IN2, alu_mux_out, FALU_IN1, FALU_IN2;
    wire [TYPE_WIDTH-1:0] Type;
    wire [DTYPE_WIDTH-1:0] dtype;
    wire [BRANCH_TYPE_WIDTH-1:0] branch_type;
    wire [ALUSELECT_WIDTH-1:0] alu_select;
    wire [ALU_OP_WIDTH-1:0] aluop;
    wire [INSTR_ADDR_WIDTH-1:0] program_counter;
    wire [INSTR_DATA_WIDTH-1:0] instruction;


    pc #(
        .BUS_WIDTH(BUS_WIDTH),
        .TYPE_WIDTH(TYPE_WIDTH),
        .DEFAULT_INCREMENT(INCREMENT)
    ) pc_inst (
        .clk(clk),
        .rst_n(reset_n),
        .jump_increment(jump_OUT),
        .branch_increment(branch_out),
        .intruction_type(Type),
        .jump_in(jump),
        .pc_out(program_counter)
    );

    rom #(
        .DEPTH(ROM_DEPTH),
        .DATA_WIDTH(INSTR_DATA_WIDTH),
        .MEM_INIT_PATH(MEM_INIT_PATH)
    ) instruction_rom (
        .clk(clk),
        .addr_i(program_counter),
        .rom_o(instruction)
    );

    jump #(
        .TYPE_SIGNAL_WIDTH(TYPE_WIDTH),
        .JAL_WIDTH(20),    // Do we want to use 32 or 20 here since it sign extends by default
        .DATA_WIDTH(DATA_WIDTH)
    ) jump_inst (
        .jump_in(jump),
        .type_in(Type),
        .JALR_in(alu_mux_out),
        .JAL_in({instruction[31], instruction[19:12], instruction[20], instruction[30:21]}),
        .addr_out(jump_OUT)
    );

    branch #(
        .DATA_WIDTH(DATA_WIDTH),
        .BRANCH_TYPE_WIDTH(BRANCH_TYPE_WIDTH),
        .BRANCH_IMM_WIDTH(12)   // DO we want 32 or 12 
    ) branch_inst (
        .register_1(d1),
        .register_2(d2),
        .branch_type(branch_type),
        .branch_imm({instruction[31], instruction[7], instruction[30:25], instruction[11:8]}),
        .addr_offset_out(branch_out)
    );
    
    lsu #(
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH(1024),
        .NUM_MEM_BLOCKS(4),
        .ADDRESS_SPACE(4096),
        .NUM_DATA_TYPES(6),
        .GPIO_A_ADDR(GPIO_A_ADDR),
        .GPIO_B_ADDR(GPIO_B_ADDR)
    ) lsu_inst (
        .clk(clk),
        .addr_in(alu_mux_out),
        .data_in(d2),
        .WE_in(mwe),
        .dtypes_in(dtype),
        .reset_n(reset_n),
        .data_out(lsu_d_out), 
        .gpioA_out(gpioA_out),
        .gpioB_out(gpioB_out)
    );


    decoder #(
        .ALUOP_WIDTH(ALU_OP_WIDTH),
        .TYPE_WIDTH(TYPE_WIDTH),
        .DTYPE_WIDTH(DTYPE_WIDTH),
        .BRANCH_TYPE_WIDTH(BRANCH_TYPE_WIDTH),
        .ALUSELECT_WIDTH(ALUSELECT_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .OPCODE_WIDTH(OPCODE_WIDTH),
        .FUNCT3_WIDTH(FUNCT3_WIDTH),
        .FUNCT7_WIDTH(FUNCT7_WIDTH),
        .FUNCT3_RIGHT(FUNCT3_RIGHT),
        .FUNCT3_LEFT(FUNCT3_LEFT)
    ) decoder_inst (
        .instr(instruction),
        .ALUOp(aluop),
        .rawType(Type),
        .load(load),
        .dType(dtype),
        .MWE(mwe),
        .RWE(we),
        .branchType(branch_type),
        .jump(jump),
        .ALUSelect(alu_select),
        .auipcBit(AUIPC_sig),
        .f_rd(f_rd),
        .f_d1(f_d1),
        .f_d2(f_d2)
    );

    regs #(
        .DATA_WIDTH(DATA_WIDTH),
        .NUM_REGS(NUM_REGS),
        .INDEX_WIDTH(INDEX_WIDTH),
        .WR_MASK(WR_MASK),
        .RA(RA), 
        .SP(SP),
        .GP(GP),
        .TP(TP),
        .RA_INIT(RA_INIT),
        .SP_INIT(SP_INIT),
        .GP_INIT(GP_INIT),
        .TP_INIT(TP_INIT)
    ) regs_inst(
        .clk(clk),
        .rst_n(reset_n),
        .WE_i(we),
        .WA_i({f_rd,instruction[11:7]}),  //some float instructions write to integer regs
        //ALSO: there will be integer to float case, use IALU and then keep alu_select[1] concat the same? yes
        .WD_i(WriteBack_data),
        .RA1_i({f_d1,instruction[19:15]}),  
        .RA2_i({f_d2,instruction[24:20]}),  //
        .RD1_o(d1),
        .RD2_o(d2)
    );

    ialu #(
        .OPCODE_WIDTH(ALU_OP_WIDTH),
        .IN_BUS_WIDTH (IN_BUS_WIDTH),
        .OUT_BUS_WIDTH(OUT_BUS_WIDTH)
    ) ialu_inst (
        .A_i(IALU_IN1),
        .B_i(IALU_IN2),
        .shamt_i(instruction[24:20]),
        .opcode_i(aluop),
        .R_o(ialu_OUT)
    );

    falu #(
        .OPCODE_WIDTH(ALU_OP_WIDTH),
        .IN_BUS_WIDTH(IN_BUS_WIDTH),
        .OUT_BUS_WIDTH(OUT_BUS_WIDTH)
    ) falu_inst (
        .A_i(d1),
        .B_i(IALU_IN2),
        .opcode_i(aluop),
        .R_o(falu_out)
    );


    

    assign i_TYPE_EXT = {{(DATA_WIDTH-IMM_LENGTH){instruction[DATA_WIDTH-1]}},instruction[DATA_WIDTH-1:DATA_WIDTH - IMM_LENGTH]};
    assign s_TYPE_EXT = {{(DATA_WIDTH-IMM_LENGTH){instruction[DATA_WIDTH-1]}},instruction[DATA_WIDTH-1:25], instruction[11:7]};
    assign u_TYPE_EXT = {instruction[DATA_WIDTH-1:IMM_LENGTH],{(IMM_LENGTH){1'b0}}};


    // MUX 4
    always @(load, lsu_d_out, alu_mux_out)   
    begin
        case(load)
            1'b1:     load_mux <= lsu_d_out;
            default:  load_mux <= alu_mux_out;
        endcase
    end

    // MUX 1
    always @(jump, program_counter, load_mux)   
    begin
        case(jump)
            1'b1:     WriteBack_data <= program_counter +4;
            default:  WriteBack_data <= load_mux;
        endcase
    end

    // MUX 3
    always @(d1, program_counter, AUIPC_sig)   
    begin
        case(AUIPC_sig)
            1'b1:     IALU_IN1 <= program_counter;
            default:  IALU_IN1 <= d1;
        endcase
    end
    
    // MUX 2
    always @(d2, i_TYPE_EXT, s_TYPE_EXT, u_TYPE_EXT, Type)   
    begin
        case(Type)
            `U_TYPE: IALU_IN2 <= u_TYPE_EXT;
            `I_TYPE: IALU_IN2 <= i_TYPE_EXT;
            `S_TYPE: IALU_IN2 <= s_TYPE_EXT;
            default: IALU_IN2 <= d2;
        endcase
    end

    // MUX 5
    always @(ialu_OUT, falu_out, alu_select)
    begin
        case(alu_select)
            `SEL_IALU: alu_mux_out <= ialu_OUT;
            `SEL_FALU: alu_mux_out <= falu_out;
            default: alu_mux_out   <= ialu_OUT;
        endcase   
    end
endmodule
