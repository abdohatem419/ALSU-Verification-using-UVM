package ALSU_sequence_item_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
typedef enum  {
    OR,
    XOR,
    ADD,
    MULT,
    SHIFT,
    ROTATE,
    INVALID_6,
    INVALID_7
  } opcode_e;
class alsu_seq_item extends uvm_sequence_item;
    `uvm_object_utils(alsu_seq_item);

    parameter  MAXPOS=  3;
    parameter  MAXNEG= -4;
    parameter  ZERO  =  0;
    parameter INPUT_PRIORITY = "A";
    parameter FULL_ADDER = "ON";

    rand bit rst, cin, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in;
    rand opcode_e opcode;
    rand bit [2:0] A, B;
    rand opcode_e arr[6];
    logic [15:0] leds,leds_g;
    logic signed [5:0] out,out_g;

    function new(string name = "alsu_seq_item");
        super.new(name);
    endfunction

    function string convert2string();
        return $sformatf("%s reset = 0b%b , cin = 0b%b , red_op_A = 0b%b , red_op_B = 0b%b , bypass_A = 0b%b, bypass_B = 0b%b, 
        direction = 0b%b , serial_in = 0b%b , opcode = %s , A = 0b%b , B = 0b%b , leds = 0b%b , out = 0b%b",super.convert2string(),rst, cin, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in,
        opcode, A, B, leds, out);
    endfunction

    function string convert2string_stimulus();
        return $sformatf("reset = 0b%b , cin = 0b%b , red_op_A = 0b%b , red_op_B = 0b%b , bypass_A = 0b%b, bypass_B = 0b%b, 
        direction = 0b%b , serial_in = 0b%b , opcode = %s , A = 0b%b , B = 0b%b",rst, cin, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in,
        opcode, A, B);
    endfunction

    constraint rs {
        rst dist {
            0:=80,
            1:=20
        };
    }
    constraint a{
        if(opcode == ADD || opcode == MULT)
            A dist{
                MAXPOS := 30,
                MAXNEG := 30,
                ZERO   := 30
            };
        else if((opcode == OR||opcode == XOR )&&(red_op_A))
            A dist{
                1:=30,
                2:=30,
                4:=30
            };
        else if((opcode == OR||opcode == XOR )&&(red_op_B))
            A dist{
                MAXPOS := 0,
                MAXNEG := 0,
                ZERO   := 30
            };
    }
    constraint b{
        if(opcode == ADD || opcode == MULT)
            B dist{
                MAXPOS := 30,
                MAXNEG := 30,
                ZERO   := 30
            };
        else if((opcode == OR||opcode == XOR )&&(red_op_A))
            B dist{
                MAXPOS := 0,
                MAXNEG := 0,
                ZERO   := 30
            };
        else if((opcode == OR||opcode == XOR )&&(red_op_B))
            B dist{
                1:=30,
                2:=30,
                4:=30
            };
    }
    constraint op{
        opcode dist{
            OR        := 50,
            XOR       := 50,
            ADD       := 50,
            MULT      := 50,
            SHIFT     := 50,
            ROTATE    := 50,
            INVALID_6 := 5,
            INVALID_7 := 5
        };
    }
    constraint bypass{
        bypass_A dist{
            0:=80,
            1:=10
        };
        bypass_B dist{
            0:=80,
            1:=10
        };
    }
    constraint fixed_array {
    // Ensure that each element of the array is within the valid range
        foreach(arr[i]) {
            arr[i] inside {[0:5]};
            foreach(arr[j]){
                if(i!=j) arr[i] != arr[j];
            }
        }
    }

endclass
endpackage