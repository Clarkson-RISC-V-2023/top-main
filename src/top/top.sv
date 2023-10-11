`timescale 1ns/1ps
`define ROM_Inst_INIT_PATH "src/top/mem_file/instruction.bin"
`define ROM_A_INIT_PATH "src/top/mem_file/a.hex"
`define ROM_B_INIT_PATH "src/top/mem_file/b.hex"

module top #(
    // ALU
    parameter TYPE_WIDTH = 3,
    parameter DTYPE_WIDTH = 3,
    parameter BRANCH_TYPE_WIDTH = 3,
    parameter ALUSELECT_WIDTH = 2,
    parameter ALU_OP_WIDTH = 5,
    parameter REG_FILE_WIDTH = 6,
    parameter IN_BUS_WIDTH = 32,
    parameter OUT_BUS_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter IMM_LENGTH = 12,
    parameter GPIO_A_ADDR = 12'hEF0,
    parameter GPIO_B_ADDR = 12'hEF4,

    // ROM (Instruction)
    parameter INSTR_DATA_WIDTH = 32,                 // Word length
    parameter INSTR_ADDR_WIDTH = 32,                 // Addr length
    parameter INSTR_WORDS = 6,                      // Words

    parameter NUM_REGS      = 32,        // 64 32-bit registers
    parameter INDEX_WIDTH   = $clog2(NUM_REGS), // number of bits needed to address NUM_REGS number of registers
    parameter WR_MASK       = 32'b1111_1111_1111_1111_1111_1111_1111_1110, // Reg x0 is read only

    // Default values for register pointers
    parameter RA             = 1,   // Return Address
    parameter SP             = 2,   // Stack-Ponter
    parameter GP             = 3,   // Global-Pointer
    parameter TP             = 4,   // Thread-Pointer

    // THIS VALUES NEED TO BE SET TO THE RIGHT INIT STATE:
    parameter RA_INIT        = 32'hFFFF_FFFF,
    parameter SP_INIT        = 32'hFFFF_FFFF,
    parameter GP_INIT        = 32'hFFFF_FFFF,
    parameter TP_INIT        = 32'hFFFF_FFFF,

    // // ROM (A)  
    // parameter A_DATA_WIDTH = 32,                    // Word length
    // parameter A_ADDR_WIDTH = INSTR_ADDR_WIDTH,      // Addr length
    // parameter A_WORDS = 6,                          // Words

    // // ROM (B)
    // parameter B_DATA_WIDTH = 32,                    // Word length
    // parameter B_ADDR_WIDTH = INSTR_ADDR_WIDTH,      // Addr length
    // parameter B_WORDS = 6,                          // Words

    // PC
    parameter BUS_WIDTH = INSTR_ADDR_WIDTH, 
    parameter INCREMENT = 4
    
)(
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

    reg clk;
    reg rst_n;

    wire we, mwe, sin_cos, overwrite, jump, branch_taken, load, AUIPC_sig;    //alu_status_i, alu_status_o;
    wire [REG_FILE_WIDTH-1:0] r1, r2, rd;
    wire [OUT_BUS_WIDTH-1:0] d1, d2, d_in_reg, lsu_d_out, ialu_OUT, jal_ext, jump_OUT, branch_out, i_TYPE_EXT, s_TYPE_EXT, u_TYPE_EXT;
    reg [OUT_BUS_WIDTH-1:0] load_mux, WriteBack_data, IALU_IN1, IALU_IN2, alu_mux_out;
    wire [TYPE_WIDTH-1:0] Type;
    wire [DTYPE_WIDTH-1:0] dtype;
    wire [BRANCH_TYPE_WIDTH-1:0] branch_type;
    wire [ALUSELECT_WIDTH-1:0] alu_select;
    wire [ALU_OP_WIDTH-1:0] aluop;
    wire [INSTR_ADDR_WIDTH-1:0] program_counter;
    wire [INSTR_DATA_WIDTH-1:0] instruction;
    // wire [A_DATA_WIDTH-1:0] a;
    // wire [B_DATA_WIDTH-1:0] b;

    wire [OUT_BUS_WIDTH-1:0] r;

    pc #(
        .BUS_WIDTH(BUS_WIDTH),
        .TYPE_WIDTH(TYPE_WIDTH),
        .INCREMENT(INCREMENT)
    ) pc_inst (
        .clk(clk),
        .rst_n(rst_n),
        .jump_increment(jump_OUT),
        .branch_increment(branch_out),
        .intruction_type(Type),
        .jump_in(overwrite),
        .pc_out(program_counter)
    );

    rom #(
        .DEPTH(256),
        .ADDR_WIDTH(INSTR_ADDR_WIDTH),
        .MEM_INIT_PATH("")
    ) instruction_rom (
        .clk(clk),
        .addr_i(program_counter),
        .data_o(instruction)
    );

    // rom #(
    //     .DATA_WIDTH(A_DATA_WIDTH),
    //     .ADDR_WIDTH(A_ADDR_WIDTH),
    //     .WORDS(A_WORDS)
    // ) a_rom (
    //     .addr_i(program_counter),
    //     .data_o(a)
    // );
    
    // rom #(
    //     .DATA_WIDTH(B_DATA_WIDTH),
    //     .ADDR_WIDTH(B_ADDR_WIDTH),
    //     .WORDS(B_WORDS)
    // ) b_rom (
    //     .addr_i(program_counter),
    //     .data_o(b)
    // );
    jump #(
        .TYPE_SIGNAL_WIDTH(TYPE_WIDTH),
        .JAL_WIDTH(20),    // Do we want to use 32 or 20 here since it sign extends by default
        .DATA_WIDTH(DATA_WIDTH)
    ) jump_inst (
        .jump_in(jump),
        .type_in(Type),
        .JALR_in(alu_mux_out),
        .JAL_in({instruction[31], instruction[19:12], instruction[20], instruction[30:21]}),
        .addr_out(jump_OUT),
        .overwrite(overwrite)
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
        .addr_offset_out(branch_out),
        .branch_taken(branch_taken)
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
        .DATA_WIDTH(DATA_WIDTH)
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
        .ALUSelect(alu_select)
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
        .WA_i(rd),
        .WD_i(WriteBack_data),
        .RA1_i(r1),
        .RA2_i(r2),
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
        .shamt(instruction[24:20]),
        .opcode_i(aluop),
        .R_o(ialu_OUT)
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
            1'b1:     WriteBack_data = program_counter +4;
            default:  WriteBack_data = load_mux;
        endcase
    end

    // MUX 3
    always @(d1, program_counter, AUIPC_sig)   
    begin
        case(AUIPC_sig)
            1'b1:     IALU_IN1 = program_counter;
            default:  IALU_IN1 = d1;
        endcase
    end
    
    // MUX 2
    always @(d2, i_TYPE_EXT, s_TYPE_EXT, u_TYPE_EXT, Type)   
    begin
        case(Type)
            `U_TYPE: IALU_IN2 = u_TYPE_EXT;
            `I_TYPE: IALU_IN2 = i_TYPE_EXT;
            `S_TYPE: IALU_IN2 = s_TYPE_EXT;
            default: IALU_IN2 = d2;
        endcase
    end

    // MUX 5
    always @(ialu_OUT, alu_select)
    begin
        case(alu_select)
            `SEL_IALU: alu_mux_out = ialu_OUT;
            default: alu_mux_out = ialu_OUT;
        endcase   
    end
    


    // initial begin
    //     // Load ROMs from files
    //     $readmemb(`ROM_Inst_INIT_PATH, instruction_rom.memory);
    //     $readmemh(`ROM_A_INIT_PATH, a_rom.memory);
    //     $readmemh(`ROM_B_INIT_PATH, b_rom.memory);

    //     $dumpfile("top_tb.vcd");
    //     $dumpvars(0, top);

    //     clk = 0;
    //     rst_n = 0;
    //     #20 rst_n = 1;
        
    //     #140 $finish;
    // end

    // always #10 clk= ~clk;

endmodule