package ALSU_agent_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import ALSU_driver_pkg::*;
import ALSU_sequence_item_pkg::*;
import ALSU_sequencer_pkg::*;
import ALSU_monitor_pkg::*;
import ALSU_config_obj_pkg::*;

class alsu_agent extends uvm_agent;
    `uvm_component_utils(alsu_agent);
    alsu_driver drv;
    alsu_sequencer sqr;
    alsu_monitor mtr;
    alsu_config_obj obj;
    uvm_analysis_port #(alsu_seq_item) agent_conn;

    function new(string name = "alsu_agent" , uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(alsu_config_obj)::get(this,"","ALSU_CONFIG_OBJ",obj)) begin
            `uvm_fatal("build phase","Unable to get the configuration object");
        end
        drv = alsu_driver::type_id::create("drv",this);
        sqr = alsu_sequencer::type_id::create("sqr",this);
        mtr = alsu_monitor::type_id::create("mtr",this);
        agent_conn = new("agent_conn",this);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        drv.alsu_vif = obj.alsu_vif;
        mtr.alsu_vif = obj.alsu_vif;
        drv.seq_item_port.connect(sqr.seq_item_export);
        mtr.mon_ap.connect(agent_conn);
    endfunction
endclass
endpackage