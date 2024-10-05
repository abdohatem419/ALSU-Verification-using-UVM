interface ALSU_interface(clk);
input bit clk;
parameter INPUT_PRIORITY = "A";
parameter FULL_ADDER = "ON";
logic rst, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in;
logic signed cin;
logic [2:0] opcode;
logic signed [2:0] A, B;            
logic [15:0] leds,leds_g;
logic signed [5:0] out,out_g;

modport DUT (input A, B, cin, serial_in, red_op_A, red_op_B, opcode, bypass_A, bypass_B, clk, rst, direction, 
            output leds, out);

modport DUT_GOLD (input A, B, cin, serial_in, red_op_A, red_op_B, opcode, bypass_A, bypass_B, clk, rst, direction, 
                 output leds_g, out_g);
endinterface