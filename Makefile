.PHONY: all ialu falu bmem 

all: build_top_sim
# TEMPORARLY disabled: lsu ialu malu

VFILES="Detached" # Detached or Attached

ialu:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING ialu
	make -C src/ip/alu/ ialu OUT_DIR=../../../out/alu/ialu/

falu:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING falu
	make -C src/ip/alu/ falu OUT_DIR=../../../out/alu/falu/

bmem:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING bmem
	make -C src/ip/mem/ bmem OUT_DIR=../../../out/mem/tb/bmem

rom:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING rom
	make -C src/ip/mem/ rom OUT_DIR=../../../out/mem/tb/rom

instr_rom:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING instr_rom
	make -C src/ip/mem/ instr_rom OUT_DIR=../../../out/mem/tb/instr_rom

ram:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING ram
	make -C src/ip/mem/ ram OUT_DIR=../../../out/mem/tb/ram

uvm_ram:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING uvm_ram
	make -C src/ip/mem/ uvm_ram IP=uvm_ram OUT_DIR=../../../out/mem/uvm/ram  XVLOG_FLAGS=./files_uvm.f

branch:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING branch
	make -C src/ip/branch/ OUT_DIR=../../../out/branch/

jump:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING jump
	make -C src/ip/jump/ OUT_DIR=../../../out/jump/

lsu:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING lsu
	make -C src/ip/lsu/ OUT_DIR=../../../out/lsu/

regs:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING regs
	make -C src/ip/regs/ OUT_DIR=../../../out/regs/ regs

pc:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING pc
	make -C src/ip/pc/ OUT_DIR=../../../out/pc/

build_top_project:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING build_top_sim
	vivado -mode batch -source vivado/project_build.tcl  -tclargs $(VFILES)
	rm -rf vivado.* vivado_* RISCy_Buisness_Processor_*

gui_build_top_project:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING top-main Vivado Project GUI mode
	# Use VFILES=<Attached/Detached> default is Detached
	vivado -mode gui -source vivado/project_build.tcl -tclargs $(VFILES)
	rm -rf vivado.* vivado_* RISCy_Buisness_Processor_*

build_top_sim:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING Top-Level Simulation
	xvlog -sv -f ./files.f src/top/verif/tb_top.sv
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
