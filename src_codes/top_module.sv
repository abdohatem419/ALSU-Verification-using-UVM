import ALSU_test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh";

module top;

bit clk;
initial begin
    clk = 0;
    forever #1 clk = ~clk;
end

ALSU_interface ALSU_if(clk);
ALSU DUT(ALSU_if);
ALSU_golden_model GOLD_DUT(ALSU_if);
bind ALSU SVA ALSU_SVA (ALSU_if);

initial begin
    uvm_config_db#(virtual ALSU_interface)::set(null,"uvm_test_top","ALSU_INTERFACE",ALSU_if);
    run_test("alsu_test");
end
endmodule