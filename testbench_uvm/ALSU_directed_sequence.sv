package ALSU_directed_sequence_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import ALSU_sequencer_pkg::*;
import ALSU_sequence_item_pkg::*;
static int i = -1;

class alsu_directed_sequence extends uvm_sequence #(alsu_seq_item);
    `uvm_object_utils(alsu_directed_sequence);
    alsu_seq_item item;

    function new(string name = "alsu_directed_sequence");
        super.new(name);
    endfunction

    task body;
        repeat(10)begin
            i++;
            item = alsu_seq_item::type_id::create("item");
            start_item(item);
            assert(item.randomize() with {opcode == i;});
            finish_item(item);
        end
    endtask
endclass
endpackage