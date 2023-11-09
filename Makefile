.PHONY: all ialu falu bmem rom instr_rom ram uvm_ram branch jump lsu regs pc build_top_project gui_build_top_project build_top_sim clean

VFILES="Detached" # Detached or Attached
DEBUG=False

IP 				= top
FILE_LIST 		= ./files.f
UVM_FILE_LIST	= ./src/top/verif/files_uvm.f
XVLOG_FLAGS 	= -sv -f $(FILE_LIST)
UVM_XVLOG_FLAGS	= -sv -L uvm -f $(UVM_FILE_LIST)
XELAB_FLAGS 	= -top tb_$(IP)
XSIM_FLAGS 		= -R tb_$(IP)
CHECK_UVM_ERROR = false
OUT_DIR			= out

all: gui_build_top_project 


build: 
	rm -rf $(OUT_DIR)/*
	mkdir -p $(OUT_DIR)
	xvlog $(XVLOG_FLAGS) 
	xelab $(XELAB_FLAGS)
	xsim $(XSIM_FLAGS)
	mv xvlog* xelab* xsim** $(OUT_DIR)
	mv *.log $(OUT_DIR) || true
	mv *.wdb $(OUT_DIR) || true
	mv *.vcd $(OUT_DIR) || true

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
	make -C src/ip/mem/ uvm_ram IP=uvm_ram OUT_DIR=../../../out/uvm/ram  XVLOG_FLAGS=./files_uvm.f

uvm_top:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING uvm_top
	make build IP=uvm_top OUT_DIR=$(OUT_DIR)/uvm/top  XVLOG_FLAGS="$(UVM_XVLOG_FLAGS)"

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

vivado_batch:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING build_top_sim
	vivado -mode batch -source vivado/project_build.tcl  -tclargs $(VFILES) -tclargs $(DEBUG)
	rm -rf vivado.* vivado_* RISCy_Buisness_Processor_*

gui_build_top_project:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING top-main Vivado Project GUI mode
	# Use VFILES=<Attached/Detached> default is Detached
	vivado -mode gui -source vivado/project_build.tcl -tclargs $(VFILES) -tclargs $(DEBUG)
	rm -rf vivado.* vivado_* RISCy_Buisness_Processor_*

debug:
	make gui_build_top_project DEBUG=True

build_top_sim:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING Top-Level Simulation
	make build IP=top OUT_DIR=$(OUT_DIR)/tb/top

clean:
	rm -rf out/ 
	rm -rf *.pb *.log *.jou *.wdb *.vcd *.xvlog *.xelab *.xsim
	rm -rf xsim.dir
