.PHONY: all ialu malu

all: init alu

init:
	rm -rf out
	mkdir -p out/

ialu:
	# Build ialu
	make -C src/ip/alu/ ialu TMP=../../../out/alu/ialu/

malu:
	# Build malu
	make -C src/ip/alu/ malu TMP=../../../out/alu/malu/

clean:
	rm -rf out/ 
	rm -rm *.pb *.log *.jou *.wdb *.vcd *.xvlog *.xelab *.xsim