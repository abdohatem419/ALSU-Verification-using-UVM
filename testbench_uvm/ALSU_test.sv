package ALSU_test_pkg;
import ALSU_env_pkg::*;
import ALSU_config_obj_pkg::*;
import ALSU_main_sequence_pkg::*;
import ALSU_reset_sequence_pkg::*;
import ALSU_directed_sequence_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class alsu_test extends uvm_test;
    `uvm_component_utils(alsu_test)
    alsu_config_obj alsu_config_obj_test;
    alsu_env env;
    virtual ALSU_interface alsu_vif;
    alsu_main_sequence main_seq;
    alsu_reset_sequence reset_seq;
    alsu_directed_sequence dir_seq;

    function new(string name = "alsu_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env=alsu_env::type_id::create("env",this);
        alsu_config_obj_test = alsu_config_obj::type_id::create("alsu_config_obj_test");
        main_seq = alsu_main_sequence::type_id::create("main_seq");
        reset_seq = alsu_reset_sequence::type_id::create("reset_seq");
        dir_seq = alsu_directed_sequence::type_id::create("dir_seq");
        if(!uvm_config_db#(virtual ALSU_interface)::get(this,"","ALSU_INTERFACE",alsu_config_obj_test.alsu_vif))
            `uvm_fatal("build phase","Unable to get the virtual interface");
        
        uvm_config_db#(alsu_config_obj)::set(null,"*","ALSU_CONFIG_OBJ",alsu_config_obj_test);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        `uvm_info("run phase","Reset asserted",UVM_LOW)
        reset_seq.start(env.alsu_agent_env.sqr);
        `uvm_info("run phase","Reset deasserted",UVM_LOW)
        `uvm_info("run phase","main sequence asserted",UVM_LOW)
        main_seq.start(env.alsu_agent_env.sqr);
        `uvm_info("run phase","main sequence deasserted",UVM_LOW)
        `uvm_info("run phase","directed sequence asserted",UVM_LOW)
        dir_seq.start(env.alsu_agent_env.sqr);
        `uvm_info("run phase","directed sequence deasserted",UVM_LOW)
        phase.drop_objection(this);
    endtask

endclass:alsu_test

endpackage