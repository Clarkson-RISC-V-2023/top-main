.PHONY: all ialu malu

all: init bmem rom ram uvm_ram branch jump  regs pc
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

top:
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# BUILDING RTL TOP:
	xvlog -f files.f

clean:
	rm -rf out/ 
	rm -rf *.pb *.log *.jou *.wdb *.vcd *.xvlog *.xelab *.xsim