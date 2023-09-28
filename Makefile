.PHONY: all ialu malu

all: init ialu malu

init:
	rm -rf out
	mkdir -p out/

ialu:
	# Build ialu
	make -C src/ip/alu/ ialu TMP=../../../out/alu/ialu/

malu:
	# Build malu
	make -C src/ip/alu/ malu TMP=../../../out/alu/malu/

bmem:
	# Makefile in repo needs to be modified
	# make -C src/ip/mem/ bmem

rom:
	# Makefile in repo needs to be modified
	# make -C src/ip/mem/ rom

ram:
	# Makefile in repo needs to be modified
	# make -C src/ip/mem/ ram

clean:
	rm -rf out/ 
	rm -rm *.pb *.log *.jou *.wdb *.vcd *.xvlog *.xelab *.xsim