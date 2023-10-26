package top_params;
       // ALU
    parameter ROM_DEPTH = 8192;
    parameter TYPE_WIDTH = 3;
    parameter DTYPE_WIDTH = 3;
    parameter BRANCH_TYPE_WIDTH = 3;
    parameter ALUSELECT_WIDTH = 2;
    parameter ALU_OP_WIDTH = 5;
    parameter REG_FILE_WIDTH = 6;
    parameter IN_BUS_WIDTH = 32;
    parameter OUT_BUS_WIDTH = 32;
    parameter TOP_DATA_WIDTH = 32;
    parameter IMM_LENGTH = 12;
    parameter GPIO_A_ADDR = 12'hEF0;
    parameter GPIO_B_ADDR = 12'hEF4;
    parameter OPCODE_WIDTH = 7;
    parameter FUNCT3_WIDTH = 3;
    parameter FUNCT7_WIDTH = 7;
    parameter FUNCT3_RIGHT = 12;
    parameter FUNCT3_LEFT = FUNCT3_WIDTH-1+FUNCT3_RIGHT;
    parameter MEM_INIT_PATH = "testtest";
    parameter string RAM_INIT_PATH[4] = {"ram1", "ram2", "ram3", "ram4"};

    // ROM (Instruction)
    parameter INSTR_DATA_WIDTH = 32;                 // Word length
    parameter INSTR_ADDR_WIDTH = 32;                 // Addr length
    parameter INSTR_WORDS = 6;                      // Words

    parameter NUM_REGS      = 32;        // 64 32-bit registers
    parameter INDEX_WIDTH   = $clog2(NUM_REGS); // number of bits needed to address NUM_REGS number of registers
    parameter WR_MASK       = 32'b1111_1111_1111_1111_1111_1111_1111_1110; // Reg x0 is read only

    // Default values for register pointers
    parameter RA             = 1;   // Return Address
    parameter SP             = 2;   // Stack-Ponter
    parameter GP             = 3;   // Global-Pointer
    parameter TP             = 4;   // Thread-Pointer

    // THIS VALUES NEED TO BE SET TO THE RIGHT INIT STATE:
    parameter RA_INIT        = 32'hFFFF_FFFF;
    parameter SP_INIT        = 32'hFFFF_FFFF;
    parameter GP_INIT        = 32'hFFFF_FFFF;
    parameter TP_INIT        = 32'hFFFF_FFFF;

    // // ROM (A)  
    // parameter A_DATA_WIDTH = 32;                    // Word length
    // parameter A_ADDR_WIDTH = INSTR_ADDR_WIDTH;      // Addr length
    // parameter A_WORDS = 6;                          // Words

    // // ROM (B)
    // parameter B_DATA_WIDTH = 32;                    // Word length
    // parameter B_ADDR_WIDTH = INSTR_ADDR_WIDTH;      // Addr length
    // parameter B_WORDS = 6;                          // Words

    // PC
    parameter BUS_WIDTH = INSTR_ADDR_WIDTH; 
    parameter INCREMENT = 4;
endpackage