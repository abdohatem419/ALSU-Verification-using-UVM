package ALSU_monitor_pkg;
import uvm_pkg::*;
`include"uvm_macros.svh"
import ALSU_sequence_item_pkg::*;

class alsu_monitor extends uvm_monitor;
    `uvm_component_utils(alsu_monitor)
    virtual ALSU_interface alsu_vif;
    alsu_seq_item monitor_seq_item;
    uvm_analysis_port #(alsu_seq_item) mon_ap;

    function new(string name = "alsu_monitor",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        mon_ap = new("mon_ap",this);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            monitor_seq_item = alsu_seq_item::type_id::create("monitor_seq_item");
            @(negedge alsu_vif.clk);
            monitor_seq_item.rst = alsu_vif.rst;
            monitor_seq_item.A = alsu_vif.A;
            monitor_seq_item.B = alsu_vif.B;
            monitor_seq_item.opcode = opcode_e'(alsu_vif.opcode);
            monitor_seq_item.serial_in = alsu_vif.serial_in;
            monitor_seq_item.direction = alsu_vif.direction;
            monitor_seq_item.cin = alsu_vif.cin;
            monitor_seq_item.red_op_A = alsu_vif.red_op_A;
            monitor_seq_item.red_op_B = alsu_vif.red_op_B;
            monitor_seq_item.bypass_A = alsu_vif.bypass_A;
            monitor_seq_item.bypass_B = alsu_vif.bypass_B;
            monitor_seq_item.out = alsu_vif.out;
            monitor_seq_item.leds = alsu_vif.leds;
            monitor_seq_item.out_g = alsu_vif.out_g;
            monitor_seq_item.leds_g = alsu_vif.leds_g;
            mon_ap.write(monitor_seq_item);
            `uvm_info("run_phase", monitor_seq_item.convert2string(),UVM_HIGH)
        end
    endtask
endclass
endpackage