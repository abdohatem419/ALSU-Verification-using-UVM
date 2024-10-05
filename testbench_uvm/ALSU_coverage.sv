package ALSU_coverage_pkg;
import ALSU_sequence_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class alsu_coverage extends uvm_component;
    `uvm_component_utils(alsu_coverage)
    uvm_analysis_export #(alsu_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(alsu_seq_item) fifo_cov;
    alsu_seq_item cov_item;
    
        covergroup cvr_gb;
        Red_op_a_cp: coverpoint cov_item.red_op_A;
        Red_op_b_cp: coverpoint cov_item.red_op_B;
        Dir_cp: coverpoint cov_item.direction;
        Cin_cp: coverpoint cov_item.cin;
        Shift_in_cp: coverpoint cov_item.serial_in;
        A_cp : coverpoint cov_item.A {
            bins A_data_0 = {cov_item.ZERO};
            bins A_data_max={cov_item.MAXPOS};
            bins A_data_min={cov_item.MAXNEG};
            bins A_data_walkingones[]={001, 010, 100} iff(cov_item.red_op_A) ;
            bins A_data_default=default;
        }
        B_cp : coverpoint cov_item.B {
            bins B_data_0 = {cov_item.ZERO};
            bins B_data_max={cov_item.MAXPOS};
            bins B_data_min={cov_item.MAXNEG};
            bins B_data_walkingones[]={001, 010, 100} iff(!cov_item.red_op_A && cov_item.red_op_B) ;
            bins B_data_default=default;
        }
        ALU_cp : coverpoint cov_item.opcode {
            bins Bins_shift[] = {SHIFT,ROTATE};
            bins Bins_arith[] = {ADD,MULT};
            bins Bins_bitwise[] = {OR,XOR};
            illegal_bins Bins_invalid = {INVALID_6,INVALID_7};
            bins Bins_trans = (OR => XOR => ADD => MULT => SHIFT => ROTATE);
        }
        cross ALU_cp,A_cp,B_cp{
            option.cross_auto_bin_max=0;
            bins add_mul_1 =  binsof(ALU_cp) intersect {ADD , MULT} && binsof(A_cp) intersect {cov_item.MAXPOS} && binsof(B_cp) intersect {cov_item.MAXPOS};
            bins add_mul_2 =  binsof(ALU_cp) intersect {ADD , MULT} && binsof(A_cp) intersect {cov_item.MAXPOS} && binsof(B_cp) intersect {cov_item.MAXNEG} ;
            bins add_mul_3 =  binsof(ALU_cp) intersect {ADD , MULT} && binsof(A_cp) intersect {cov_item.MAXPOS} && binsof(B_cp) intersect {cov_item.ZERO};
            bins add_mul_4 =  binsof(ALU_cp) intersect {ADD , MULT} && binsof(A_cp) intersect {cov_item.MAXNEG} && binsof(B_cp) intersect {cov_item.MAXPOS};
            bins add_mul_5 =  binsof(ALU_cp) intersect {ADD , MULT} && binsof(A_cp) intersect {cov_item.MAXNEG} && binsof(B_cp) intersect {cov_item.MAXNEG};
            bins add_mul_6 =  binsof(ALU_cp) intersect {ADD , MULT} && binsof(A_cp) intersect {cov_item.MAXNEG} && binsof(B_cp) intersect {cov_item.ZERO};
            bins add_mul_7 =  binsof(ALU_cp) intersect {ADD , MULT} && binsof(A_cp) intersect {cov_item.ZERO} && binsof(B_cp) intersect {cov_item.MAXPOS};
            bins add_mul_8 =  binsof(ALU_cp) intersect {ADD , MULT} && binsof(A_cp) intersect {cov_item.ZERO} && binsof(B_cp) intersect {cov_item.MAXNEG};
            bins add_mul_9 =  binsof(ALU_cp) intersect {ADD , MULT} && binsof(A_cp) intersect {cov_item.ZERO} && binsof(B_cp) intersect {cov_item.ZERO};
        }
        cross ALU_cp,A_cp,B_cp{
            option.cross_auto_bin_max=0;
            bins add_mul_10 = binsof(ALU_cp) intersect {ADD , MULT} && binsof(B_cp) intersect {cov_item.MAXPOS} && binsof(A_cp) intersect {cov_item.MAXPOS};
            bins add_mul_11 = binsof(ALU_cp) intersect {ADD , MULT} && binsof(B_cp) intersect {cov_item.MAXPOS} && binsof(A_cp) intersect {cov_item.MAXNEG};
            bins add_mul_12 = binsof(ALU_cp) intersect {ADD , MULT} && binsof(B_cp) intersect {cov_item.MAXPOS} && binsof(A_cp) intersect {cov_item.ZERO};
            bins add_mul_13 = binsof(ALU_cp) intersect {ADD , MULT} && binsof(B_cp) intersect {cov_item.MAXNEG} && binsof(A_cp) intersect {cov_item.MAXPOS};
            bins add_mul_14 = binsof(ALU_cp) intersect {ADD , MULT} && binsof(B_cp) intersect {cov_item.MAXNEG} && binsof(A_cp) intersect {cov_item.MAXNEG};
            bins add_mul_15 = binsof(ALU_cp) intersect {ADD , MULT} && binsof(B_cp) intersect {cov_item.MAXNEG} && binsof(A_cp) intersect {cov_item.ZERO};
            bins add_mul_16 = binsof(ALU_cp) intersect {ADD , MULT} && binsof(B_cp) intersect {cov_item.ZERO} && binsof(A_cp) intersect {cov_item.MAXPOS};
            bins add_mul_17 = binsof(ALU_cp) intersect {ADD , MULT} && binsof(B_cp) intersect {cov_item.ZERO} && binsof(A_cp) intersect {cov_item.MAXNEG};
            bins add_mul_18 = binsof(ALU_cp) intersect {ADD , MULT} && binsof(B_cp) intersect {cov_item.ZERO} && binsof(A_cp) intersect {cov_item.ZERO};
        }

        cross ALU_cp,Cin_cp{
            option.cross_auto_bin_max=0;
            bins check_cin = binsof(ALU_cp) intersect {ADD} && binsof(Cin_cp) intersect{0,1};
        }
        cross ALU_cp,Shift_in_cp{
            option.cross_auto_bin_max=0;
            bins check_shift = binsof(ALU_cp) intersect {SHIFT} && binsof(Shift_in_cp) intersect{0,1};
        }
        cross ALU_cp,Dir_cp{
            option.cross_auto_bin_max=0;
            bins check_direction = binsof(ALU_cp) intersect {SHIFT , ROTATE} && binsof(Dir_cp) intersect{0,1};
        }
        cross ALU_cp,Red_op_a_cp,A_cp,B_cp{
            option.cross_auto_bin_max=0;
            bins check_op_a_0 = binsof(ALU_cp) intersect {OR , XOR} && binsof(Red_op_a_cp) intersect{1} && binsof(A_cp) intersect {001,010,100} && binsof(B_cp) intersect{0};
        }
        cross ALU_cp,Red_op_b_cp,A_cp,B_cp{
            option.cross_auto_bin_max=0;
            bins check_op_b_0 = binsof(ALU_cp) intersect {OR , XOR} && binsof(Red_op_b_cp) intersect{1} && binsof(B_cp) intersect {001,010,100} && binsof(A_cp) intersect{0};
        }
        cross ALU_cp,Red_op_a_cp,Red_op_b_cp{
            option.cross_auto_bin_max=0;
            bins invalid_1 = binsof(ALU_cp) intersect {ADD,MULT,SHIFT,ROTATE,INVALID_6,INVALID_7} && binsof(Red_op_a_cp) intersect{1};
            bins invalid_2 = binsof(ALU_cp) intersect {ADD,MULT,SHIFT,ROTATE,INVALID_6,INVALID_7} && binsof(Red_op_b_cp) intersect{1};
        }
    endgroup

     function new(string name = "alsu_coverage",uvm_component parent = null);
        super.new(name,parent);
        cvr_gb = new();
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        cov_export = new("cov_export",this);
        fifo_cov = new("fifo_cov",this);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        cov_export.connect(fifo_cov.analysis_export);
    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        forever begin
            fifo_cov.get(cov_item);
            cvr_gb.sample();
        end
    endtask

endclass
endpackage