package ALSU_reset_sequence_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import ALSU_sequencer_pkg::*;
import ALSU_sequence_item_pkg::*;

class alsu_reset_sequence extends uvm_sequence #(alsu_seq_item);
    `uvm_object_utils(alsu_reset_sequence);
    alsu_seq_item item;

    function new(string name = "alsu_reset_sequence");
        super.new(name);
    endfunction

    task body;
            item = alsu_seq_item::type_id::create("item");
            start_item(item);
            item.rst = 1;
            item.A = 0;
            item.B = 0;
            item.serial_in = 0;
            item.opcode = opcode_e'(0);
            item.direction = 0;
            item.cin = 0;
            item.red_op_A = 0;
            item.red_op_B = 0;
            item.bypass_A = 0;
            item.bypass_B = 0;
            finish_item(item);
    endtask
endclass
endpackage