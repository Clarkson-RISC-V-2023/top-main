.PHONY: all pc_sim rom_sim alu_sim

pc_sim: init pc end
rom_sim: init rom end
alu_sim: init alu end
all: init pc_sim rom_sim init alu end

init:
	mkdir -p out/

end:
	rm *.pb *.log *.jou || true
	tree
	
pc:	
	mkdir -p out/pc/iverilog/
	mkdir -p out/pc/xilinx/

	iverilog -o out/pc/iverilog/pc_sim -s tb_pc src/ip/pc/verif/tb_pc.sv src/ip/pc/rtl/pc.sv
	vvp out/pc/iverilog/pc_sim
	mv *.vcd out/pc/iverilog/

	xvlog --sv src/ip/pc/verif/tb_pc.sv src/ip/pc/rtl/pc.sv
	xelab tb_pc -debug typical
	xsim tb_pc -R
	
	mv xsim.dir out/pc/xilinx
	mv *.wdb *.vcd out/pc/xilinx

rom:
	mkdir -p out/rom/iverilog/
	mkdir -p out/rom/xilinx/

	iverilog -g2005-sv -D ROM_INIT_PATH=\"./src/ip/rom/init_rom.mem\" -o out/rom/iverilog/rom_sim -s tb_rom src/ip/rom/verif/tb_rom.sv src/ip/rom/rtl/rom.sv -y ./src/ip/rom/ 
	vvp out/rom/iverilog/rom_sim
	mv rom_sim.vcd out/rom/iverilog

	xvlog --sv -d ROM_INIT_PATH=\"./src/ip/rom/init_rom.mem\" src/ip/rom/verif/tb_rom.sv src/ip/rom/rtl/rom.sv
	xelab tb_rom -debug typical
	xsim tb_rom -R
	
	mv xsim.dir out/rom/xilinx
	mv *.wdb *.vcd out/rom/xilinx

alu:
	mkdir -p out/alu/iverilog/
	mkdir -p out/alu/xilinx/

	iverilog -o out/alu/iverilog/alu_sim -s tb_alu src/ip/alu/verif/tb_alu.sv src/ip/alu/rtl/alu.sv
	vvp out/alu/iverilog/alu_sim
	mv alu.vcd out/alu/iverilog/

	xvlog --sv src/ip/alu/verif/tb_alu.sv src/ip/alu/rtl/alu.sv
	xelab tb_alu -debug typical
	xsim tb_alu -R
	
	mv xsim.dir out/alu/xilinx
	mv *.wdb *.vcd out/alu/xilinx
	
clean:
	rm -rf out/ || true
	rm *.pb *.log *.jou *.wdb *.vcd || true