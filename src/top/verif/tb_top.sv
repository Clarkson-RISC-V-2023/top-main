// ROM_INIT_PATH is set in top_params.sv
import top_params::*;

module tb_top ();

reg clk;
reg reset_n;
reg serial;
reg programming_mode
wire [31:0] gpioA;
wire [31:0] gpioB;

top dut_top( 
    // TODO see #33
    //.clk(clk),
    .clk_i(clk),
    .reset_n(reset_n),
    .serial_i(serial),
    .programming_mode_o(programming_mode),
    .gpioA_out(gpioA),
    .gpioB_in(gpioB)
);

always #1 clk= ~clk;

initial begin
    $readmemb(MEM_INIT_PATH, dut_top.instruction_rom.mem_inst.bmem);   
    $dumpfile("tb_top.vcd");
    $dumpvars(0, tb_top);
    $display("ROM data loaded from %s", MEM_INIT_PATH);
    clk = 1'b0;
    reset_n = 1'b0;
    serial = 1'b1;
    #100ns
    reset_n = 1'b1;
    #1000000ns

    $finish; 
end

endmodule
