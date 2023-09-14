`timescale 1ns/1ps
`define ROM_Inst_INIT_PATH "src/top/mem_file/instruction.bin"
`define ROM_A_INIT_PATH "src/top/mem_file/a.hex"
`define ROM_B_INIT_PATH "src/top/mem_file/b.hex"

module top #(
    // ALU
    parameter OPCODE_WIDTH = 4,
    parameter IN_BUS_WIDTH = 32,
    parameter OUT_BUS_WIDTH = 32,

    // ROM (Instruction)
    parameter INSTR_DATA_WIDTH = 4,                 // Word length
    parameter INSTR_ADDR_WIDTH = 4,                 // Addr length
    parameter INSTR_WORDS = 6,                      // Words

    // ROM (A)  
    parameter A_DATA_WIDTH = 32,                    // Word length
    parameter A_ADDR_WIDTH = INSTR_ADDR_WIDTH,      // Addr length
    parameter A_WORDS = 6,                          // Words

    // ROM (B)
    parameter B_DATA_WIDTH = 32,                    // Word length
    parameter B_ADDR_WIDTH = INSTR_ADDR_WIDTH,      // Addr length
    parameter B_WORDS = 6,                          // Words

    // PC
    parameter BUS_WIDTH = INSTR_ADDR_WIDTH, 
    parameter INCREMENT = 1
    
)();

    reg clk;
    reg rst_n;

    wire alu_status_i, alu_status_o;

    wire [INSTR_ADDR_WIDTH-1:0] program_counter;
    wire [INSTR_DATA_WIDTH-1:0] instruction;
    wire [A_DATA_WIDTH-1:0] a;
    wire [B_DATA_WIDTH-1:0] b;

    wire [OUT_BUS_WIDTH-1:0] r;

    pc #(
        .BUS_WIDTH(BUS_WIDTH),
        .INCREMENT(INCREMENT)
    ) pc_inst (
        .clk(clk),
        .rst_n(rst_n),
        .enable(1'b1),
        .pc_out(program_counter)
    );

    rom #(
        .DATA_WIDTH(INSTR_DATA_WIDTH),
        .ADDR_WIDTH(INSTR_ADDR_WIDTH),
        .WORDS(INSTR_WORDS)
    ) instruction_rom (
        .addr_i(program_counter),
        .data_o(instruction)
    );

    rom #(
        .DATA_WIDTH(A_DATA_WIDTH),
        .ADDR_WIDTH(A_ADDR_WIDTH),
        .WORDS(A_WORDS)
    ) a_rom (
        .addr_i(program_counter),
        .data_o(a)
    );
    
    rom #(
        .DATA_WIDTH(B_DATA_WIDTH),
        .ADDR_WIDTH(B_ADDR_WIDTH),
        .WORDS(B_WORDS)
    ) b_rom (
        .addr_i(program_counter),
        .data_o(b)
    );

    alu #(
        .OPCODE_WIDTH(OPCODE_WIDTH),
        .IN_BUS_WIDTH (IN_BUS_WIDTH),
        .OUT_BUS_WIDTH(OUT_BUS_WIDTH)
    ) alu_inst (
        .A_i(a),
        .B_i(b),
        .opcode_i(instruction),
        .status_i(alu_status_i),
        .status_o(alu_status_o),
        .R_o(r)
    );

    initial begin
        // Load ROMs from files
        $readmemb(`ROM_Inst_INIT_PATH, instruction_rom.memory);
        $readmemh(`ROM_A_INIT_PATH, a_rom.memory);
        $readmemh(`ROM_B_INIT_PATH, b_rom.memory);

        $dumpfile("top_tb.vcd");
        $dumpvars(0, top);

        clk = 0;
        rst_n = 0;
        #20 rst_n = 1;
        
        #140 $finish;
    end

    always #10 clk= ~clk;

endmodule