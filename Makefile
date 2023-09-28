.PHONY: all ialu malu

all: init ialu malu bmem rom ram branch jump

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
	make -C src/ip/mem/ bmem OUT_DIR=../../../out/mem/bmem

rom:
	make -C src/ip/mem/ rom OUT_DIR=../../../out/mem/rom

ram:
	make -C src/ip/mem/ ram OUT_DIR=../../../out/mem/ram

branch:
	make -C src/ip/branch/ OUT_DIR=../../../out/branch

jump:
	make -C src/ip/jump/ OUT_DIR=../../../out/jump

lsu:
	make -C src/ip/lsu/ OUT_DIR=../../../out/lsu

clean:
	rm -rf out/ 
	rm -rf *.pb *.log *.jou *.wdb *.vcd *.xvlog *.xelab *.xsim