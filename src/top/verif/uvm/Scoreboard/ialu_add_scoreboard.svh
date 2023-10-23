`include "uvm_macros.svh"
import uvm_pkg::*;

class ialu_add_scoreboard extends uvm_scoreboard;
    
    `uvm_component_utils(ialu_add_scoreboard)
    function new(string name = "DEFAULT ialu_add scoreboard", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    int mem_space = DEPTH;
    li_item refq;
    uvm_analysis_imp #(li_item, ialu_add_scoreboard) m_analysis_imp; // Monittor analysis

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_analysis_imp = new("m_analysis_imp", this);
    endfunction

    virtual function write(li_item item);
        item.print();
        // if(item.regs_wr_en) begin
        //     // TODO function implementation to detect register writes
        // end

        // if(!item.regs_wr_en) begin
        //     // TODO function implementation to detect rgister reads
        // end
    endfunction
endclass