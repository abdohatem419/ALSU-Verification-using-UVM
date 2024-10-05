package ALSU_driver_pkg;
import ALSU_config_obj_pkg::*;
import ALSU_sequence_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class alsu_driver extends uvm_driver #(alsu_seq_item);
    `uvm_component_utils(alsu_driver);
    virtual ALSU_interface alsu_vif;
    alsu_seq_item alsu_seq_item_e;
    
    function new(string name = "alsu_driver",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            alsu_seq_item_e = alsu_seq_item::type_id::create("alsu_seq_item_e");
            seq_item_port.get_next_item(alsu_seq_item_e);
            alsu_vif.rst=alsu_seq_item_e.rst;
            alsu_vif.A=alsu_seq_item_e.A; 
            alsu_vif.B=alsu_seq_item_e.B;
            alsu_vif.cin=alsu_seq_item_e.cin;
            alsu_vif.serial_in=alsu_seq_item_e.serial_in;
            alsu_vif.red_op_A=alsu_seq_item_e.red_op_A;
            alsu_vif.red_op_B=alsu_seq_item_e.red_op_B;
            alsu_vif.opcode=alsu_seq_item_e.opcode;
            alsu_vif.bypass_A=alsu_seq_item_e.bypass_A;
            alsu_vif.bypass_B=alsu_seq_item_e.bypass_B;
            alsu_vif.direction=alsu_seq_item_e.direction;
            @(negedge alsu_vif.clk);
            alsu_seq_item_e.out    = alsu_vif.out;
            alsu_seq_item_e.out_g  = alsu_vif.out_g;
            alsu_seq_item_e.leds   = alsu_vif.leds;
            alsu_seq_item_e.leds_g = alsu_vif.leds_g;
            seq_item_port.item_done();
            `uvm_info("run_phase",alsu_seq_item_e.convert2string_stimulus(),UVM_HIGH)
        end
    endtask
endclass
endpackage