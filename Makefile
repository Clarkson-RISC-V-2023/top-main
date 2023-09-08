.PHONY: all pc_sim rom_sim

pc_sim: init pc
rom_sim: init rom
all: pc_sim rom_sim

init:
	mkdir -p out
	tree

pc:
	iverilog -o out/pc_sim -s tb_pc src/ip/pc/verif/tb_pc.sv src/ip/pc/rtl/pc.sv
	tree
	cd out/ 
	vvp pc_sim
	cd ..
	tree

rom:
	iverilog -o out/rom_sim -s tb_rom src/ip/rom/verif/tb_rom.sv src/ip/rom/rtl/rom.sv -y ./src/ip/rom/
	cd out/ 
	vvp rom_sim
	cd ..
	tree

alu:
	iverilog -o out/alu_sim -s tb_alu src/ip/alu/verif/tb_alu.sv src/ip/alu/rtl/alu.sv
	cd out/ 
	vvp alu_sim
	cd .. 
	tree
clean:
	rm -rf out/
	tree
