package ALSU_scoreboard_pkg;
import ALSU_sequence_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
static int error_count = 0;
static int correct_count  = 0;

class alsu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(alsu_scoreboard)
    uvm_analysis_export #(alsu_seq_item) sc_export;
    uvm_tlm_analysis_fifo #(alsu_seq_item) fifo_sc;
    alsu_seq_item item;

     function new(string name = "alsu_scoreboard",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        sc_export = new("sc_export",this);
        fifo_sc = new("fifo_sc",this);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        sc_export.connect(fifo_sc.analysis_export);
    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        forever begin
            fifo_sc.get(item);
            if((item.out !== item.out_g)||(item.leds != item.leds_g)) begin
                `uvm_error("run_phase",$sformatf("error encoutered expected out = 0b%b ,expected leds = 0b%b design stimulus and output : %s",item.out_g,item.leds_g,item.convert2string()))
                error_count++;
            end
            else begin
                `uvm_info("run_phase",$sformatf("correct output : %s",item.convert2string()),UVM_HIGH)
                correct_count++;
            end
        end
    endtask

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("report_phase",$sformatf("correct cases : %d",correct_count),UVM_MEDIUM)
        `uvm_info("report_phase",$sformatf("error cases : %d",error_count),UVM_MEDIUM)
    endfunction
endclass
endpackage