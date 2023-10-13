.PHONY: all ialu malu

all: build_top_sim
# TEMPORARLY disabled: lsu ialu malu

init:
	rm -rf out
	mkdir -p out/

ialu:
	# Build ialu
	make -C src/ip/alu/ ialu OUT_DIR=../../../out/alu/ialu/

malu:
	# Build malu
	make -C src/ip/alu/ malu OUT_DIR=../../../out/alu/malu/

bmem:
	make -C src/ip/mem/ bmem OUT_DIR=../../../out/mem/tb/bmem

rom:
	make -C src/ip/mem/ rom OUT_DIR=../../../out/mem/tb/rom

ram:
	make -C src/ip/mem/ ram OUT_DIR=../../../out/mem/tb/ram

uvm_ram:
	make -C src/ip/mem/ uvm_ram IP=uvm_ram OUT_DIR=../../../out/mem/uvm/ram  XVLOG_FLAGS=./files_uvm.f

branch:
	make -C src/ip/branch/ OUT_DIR=../../../out/branch/

jump:
	make -C src/ip/jump/ OUT_DIR=../../../out/jump/

lsu:
	make -C src/ip/lsu/ OUT_DIR=../../../out/lsu/

regs:
	make -C src/ip/regs/ OUT_DIR=../../../out/regs/ regs

pc:
	make -C src/ip/pc/ OUT_DIR=../../../out/pc/

build_top_project:
	vivado -mode batch -source vivado/project_build.tcl 
	rm -rf out/vivado_project/**.hw out/vivado_project/**.cache out/vivado_project/**.ip_user_files out/vivado_project/**.Xil out/vivado_project/**.xpr out/vivado_project/**.runs
	rm -rf vivado.* vivado_* RISCy_Buisness_Processor_*

build_top_sim:
	xvlog -sv src/top/top.sv verif/tb_top.sv src/ip/alu/rtl/ialu.sv src/ip/branch/rtl/branch.sv src/ip/decoder/rtl/decoder.sv src/ip/jump/rtl/jump.sv src/ip/lsu/rtl/lsu.sv src/ip/mem/rtl/memblock.sv src/ip/mem/rtl/ram.sv src/ip/mem/rtl/rom.sv src/ip/pc/rtl/pc.sv src/ip/regs/rtl/regs.sv src/ip/mem/params/ram_params.sv
	xelab -debug typical -top tb_top
	xsim tb_top -R
	mkdir -p ./out/tb_top/
	mv xvlog* xelab* xsim** ./out/tb_top/
	mv *.log ./out/tb_top/ || true
	mv *.wdb ./out/tb_top/ || true
	mv *.vcd ./out/tb_top/ || true

clean:
	rm -rf out/ 
	rm -rf *.pb *.log *.jou *.wdb *.vcd *.xvlog *.xelab *.xsim
	rm -rf xsim.dir
