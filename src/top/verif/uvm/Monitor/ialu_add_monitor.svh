class ialu_add_monitor extends uvm_monitor  
    `uvm_component_utils(ialu_add_monitor)

    function new(string name = "DEFAULT RAM monitor", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    uvm_analysis_port #(li_item) mon_analysis_port;
    virtual top_vif vif;
    semaphore sema4;

    virtual function void build_phase(uvm_phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual top_vif)::get(this, "", "top_vif", vif))
            `uvm_fatal(get_type_name(), "Could not get a hold of vif")
        sema4 =  new(1);
        mon_analysis_port = new("mon_analysis_port", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        // Initial test for load word
        // din falling edge
        forever begin
            li_item item = new;
            @ (posedge vif.clk);
            item.rs1 = vif.reg_file_rs1;
            item.rs2 = vif.reg_file_rs2;
            item.rd = vif.reg_file_rd;
            item.imm = vif.ialu_imm [11:0];
            @ (negedge);
            item.din = vif.reg_file_din

            // Send packet to scoreboard to be analyzed
            mon_analysis_port.write(item);
        end 
    endtask
endclass