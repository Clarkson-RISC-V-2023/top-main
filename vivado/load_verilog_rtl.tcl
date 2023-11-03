import_files -norecurse ./testtest
add_files -norecurse -scan_for_includes ./src/top/params/top_params.sv
import_files -norecurse ./src/top/params/top_params.sv
add_files -norecurse -scan_for_includes ./src/top/top.sv
import_files -norecurse ./src/top/top.sv

add_files -norecurse -scan_for_includes ./src/ip/alu/rtl/ialu.sv
import_files -norecurse ./src/ip/alu/rtl/ialu.sv
add_files -norecurse -scan_for_includes src/ip/alu/rtl/falu.sv
import_files -norecurse src/ip/alu/rtl/falu.sv

add_files -norecurse -scan_for_includes ./src/ip/branch/rtl/branch.sv
import_files -norecurse ./src/ip/branch/rtl/branch.sv

add_files -norecurse -scan_for_includes ./src/ip/decoder/params/riscv_instr.sv
import_files -norecurse ./src/ip/decoder/params/riscv_instr.sv
add_files -norecurse -scan_for_includes ./src/ip/decoder/rtl/decoder.sv
import_files -norecurse ./src/ip/decoder/rtl/decoder.sv

add_files -norecurse -scan_for_includes ./src/ip/jump/rtl/jump.sv
import_files -norecurse ./src/ip/jump/rtl/jump.sv

add_files -norecurse -scan_for_includes ./src/ip/lsu/rtl/lsu.sv
import_files -norecurse ./src/ip/lsu/rtl/lsu.sv

add_files -norecurse -scan_for_includes ./src/ip/mem/params/ram_params.sv
import_files -norecurse ./src/ip/mem/params/ram_params.sv
add_files -norecurse -scan_for_includes ./src/ip/mem/rtl/memblock.sv
import_files -norecurse ./src/ip/mem/rtl/memblock.sv
add_files -norecurse -scan_for_includes ./src/ip/mem/rtl/rom.sv
import_files -norecurse ./src/ip/mem/rtl/rom.sv
add_files -norecurse -scan_for_includes ./src/ip/mem/rtl/ram.sv
import_files -norecurse ./src/ip/mem/rtl/ram.sv
add_files -norecurse -scan_for_includes ./src/ip/mem/rtl/instr_rom.sv
import_files -norecurse ./src/ip/mem/rtl/instr_rom.sv
add_files -norecurse -scan_for_includes ./src/ip/mem/rtl/uart_rx.sv
import_files -norecurse ./src/ip/mem/rtl/uart_rx.sv

add_files -norecurse -scan_for_includes ./src/ip/pc/rtl/pc.sv
import_files -norecurse ./src/ip/pc/rtl/pc.sv

add_files -norecurse -scan_for_includes ./src/ip/regs/rtl/regs.sv
import_files -norecurse ./src/ip/regs/rtl/regs.sv

add_files -norecurse -scan_for_includes ./src/ip/sextend/rtl/sign_extend.sv
import_files -norecurse ./src/ip/sextend/rtl/sign_extend.sv

add_files -fileset constrs_1 -norecurse $PROJECT_CONSTRAINT_FILE
import_files -norecurse $PROJECT_CONSTRAINT_FILE