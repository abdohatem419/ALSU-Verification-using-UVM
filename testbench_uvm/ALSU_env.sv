package ALSU_env_pkg;

import uvm_pkg::*; 
`include "uvm_macros.svh"
import ALSU_agent_pkg::*;
import ALSU_coverage_pkg::*;
import ALSU_scoreboard_pkg::*;

  class alsu_env extends uvm_env;
    `uvm_component_utils(alsu_env)
    alsu_agent alsu_agent_env;
    alsu_scoreboard env_sc;
    alsu_coverage env_cvr;

    function new(string name = "alsu_env", uvm_component parent = null);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      alsu_agent_env=alsu_agent::type_id::create("alsu_agent_env",this);
      env_sc=alsu_scoreboard::type_id::create("env_sc",this);
      env_cvr=alsu_coverage::type_id::create("env_cvr",this);
    endfunction

    function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      alsu_agent_env.agent_conn.connect(env_sc.sc_export);
      alsu_agent_env.agent_conn.connect(env_cvr.cov_export);
    endfunction

  endclass: alsu_env

endpackage: ALSU_env_pkg

