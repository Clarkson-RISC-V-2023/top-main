`ifndef TOP_PARAMS_PKG
`define TOP_PARAMS_PKG

package top_params;
       // ALU
    localparam ROM_DEPTH = 512;
    localparam TYPE_WIDTH = 3;
    localparam DTYPE_WIDTH = 3;
    localparam BRANCH_TYPE_WIDTH = 3;
    localparam ALUSELECT_WIDTH = 2;
    localparam ALU_OP_WIDTH = 5;
    localparam REG_FILE_WIDTH = 6;
    localparam IN_BUS_WIDTH = 32;
    localparam OUT_BUS_WIDTH = 32;
    localparam TOP_DATA_WIDTH = 32;
    localparam IMM_LENGTH = 12;
    localparam GPIO_A_ADDR = 12'hEF0;
    localparam GPIO_B_ADDR = 12'hEF4;
    localparam OPCODE_WIDTH = 7;
    localparam FUNCT3_WIDTH = 3;
    localparam FUNCT7_WIDTH = 7;
    localparam FUNCT3_RIGHT = 12;
    localparam FUNCT3_LEFT = FUNCT3_WIDTH-1+FUNCT3_RIGHT;
    localparam  MEM_INIT_PATH = "";

    // ROM (Instruction)
    localparam INSTR_DATA_WIDTH = 32;                 // Word length
    localparam INSTR_ADDR_WIDTH = 32;                 // Addr length
    localparam INSTR_WORDS = 6;                      // Words
    localparam ROM_BAUD_FACTOR = 868;
    localparam ROM_NUM_BYTES = 4;

    localparam NUM_REGS      = 32;        // 64 32-bit registers
    localparam INDEX_WIDTH   = $clog2(NUM_REGS); // number of bits needed to address NUM_REGS number of registers
    localparam WR_MASK       = 32'b1111_1111_1111_1111_1111_1111_1111_1110; // Reg x0 is read only

    // Default values for register pointers
    localparam RA             = 1;   // Return Address
    localparam SP             = 2;   // Stack-Ponter
    localparam GP             = 3;   // Global-Pointer
    localparam TP             = 4;   // Thread-Pointer

    // THIS VALUES NEED TO BE SET TO THE RIGHT INIT STATE:
    localparam RA_INIT        = 32'hFFFF_FFFF;
    localparam SP_INIT        = 32'hFFFF_FFFF;
    localparam GP_INIT        = 32'hFFFF_FFFF;
    localparam TP_INIT        = 32'hFFFF_FFFF;

    // // ROM (A)  
    // localparam A_DATA_WIDTH = 32;                    // Word length
    // localparam A_ADDR_WIDTH = INSTR_ADDR_WIDTH;      // Addr length
    // localparam A_WORDS = 6;                          // Words

    // // ROM (B)
    // localparam B_DATA_WIDTH = 32;                    // Word length
    // localparam B_ADDR_WIDTH = INSTR_ADDR_WIDTH;      // Addr length
    // localparam B_WORDS = 6;                          // Words

    // PC
    localparam BUS_WIDTH = INSTR_ADDR_WIDTH; 
    localparam INCREMENT = 4;
endpackage

import top_params::*;
`endif