// ROM_INIT_PATH is set in top_params.sv
import top_params::*;

module tb_top ();

reg clk;
reg reset_n;
wire [31:0] gpioA;
wire [31:0] gpioB;

top dut_top( 
    .clk(clk),
    .reset_n(reset_n),
    .gpioA_out(gpioA),
    .gpioB_out(gpioB)
);

always #10 clk= ~clk;

initial begin
    $readmemb(MEM_INIT_PATH, dut_top.instruction_rom.mem_inst.bmem);   
    $dumpfile("tb_top.vcd");
    $dumpvars(0, tb_top);
    $display("ROM data loaded from %s", MEM_INIT_PATH);
    clk = 1'b0;
    reset_n = 1'b0; 
    #100ns
    reset_n = 1'b1;
    #25ms

    $finish; 
end

endmodule
