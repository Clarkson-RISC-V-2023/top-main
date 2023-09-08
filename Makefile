.PHONY: all pc_sim rom_sim alu_sim

pc_sim: init pc
rom_sim: init rom
alu_sim: init alu 
all: init pc_sim rom_sim init alu end

init:
	mkdir -p out
	tree

end:
	tree

pc:
	iverilog -o out/pc_sim -s tb_pc src/ip/pc/verif/tb_pc.sv src/ip/pc/rtl/pc.sv
	cd out
	vvp out/pc_sim
	cd ..

rom:
	iverilog -o out/rom_sim -s tb_rom src/ip/rom/verif/tb_rom.sv src/ip/rom/rtl/rom.sv -y ./src/ip/rom/ 
	cd out
	vvp out/rom_sim
	cd ..

alu:
	iverilog -o out/alu_sim -s tb_alu src/ip/alu/verif/tb_alu.sv src/ip/alu/rtl/alu.sv
	cd out
	vvp out/alu_sim
	cd ..

clean:
	rm -rf out/
	tree
