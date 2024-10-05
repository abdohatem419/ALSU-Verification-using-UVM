module SVA (ALSU_interface.DUT ALSU_if);

always_comb begin
	if(ALSU_if.rst) begin
		a_reset: assert final(ALSU_if.out == 0);
		b_reset: assert final(ALSU_if.leds == 0);
	end
end

property p2;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
	((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) 
	|->##2 ALSU_if.leds == ~$past(ALSU_if.leds);
endproperty

assert property(p2);
cover property(p2);

property p3;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h2) |->##2 ALSU_if.out == $past(ALSU_if.A,2) + $past(ALSU_if.B,2) + $past(ALSU_if.cin,2);
endproperty

assert property(p3);
cover property(p3);

property p4;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h4 && ALSU_if.direction) |->##2 (ALSU_if.out == { $past(ALSU_if.out[4:0],1), $past(ALSU_if.serial_in,2) });
endproperty

assert property(p4);
cover property(p4);

property p5;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h4 && !ALSU_if.direction) |->##2 (ALSU_if.out == { $past(ALSU_if.serial_in,2) , $past(ALSU_if.out[5:1],1) });
endproperty

assert property(p5);
cover property(p5);

property p6;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h5 && ALSU_if.direction) |->##2 (ALSU_if.out == { $past(ALSU_if.out[4:0],1), $past(ALSU_if.out[5],1) });
endproperty

assert property(p6);
cover property(p6);

property p7;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h5 && !ALSU_if.direction) |->##2 (ALSU_if.out == { $past(ALSU_if.out[0],1) , $past(ALSU_if.out[5:1],1) });
endproperty

assert property(p7);
cover property(p7);

property p8;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h0 && ALSU_if.red_op_A && ALSU_if.red_op_B) |->##2 (ALSU_if.out == (ALSU_if.INPUT_PRIORITY == "A" ? |$past(ALSU_if.A,2) : |$past(ALSU_if.B,2)));
endproperty

assert property(p8);
cover property(p8);

property p9;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h0 && ALSU_if.red_op_A && !ALSU_if.red_op_B) |->##2 (ALSU_if.out == |$past(ALSU_if.A,2));
endproperty

assert property(p9);
cover property(p9);

property p10;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h0 && !ALSU_if.red_op_A && ALSU_if.red_op_B) |->##2 (ALSU_if.out == |$past(ALSU_if.B,2));
endproperty

assert property(p10);
cover property(p10);

property p11;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h0 && !ALSU_if.red_op_A && !ALSU_if.red_op_B) |->##2 (ALSU_if.out == $past(ALSU_if.A,2) | $past(ALSU_if.B,2));
endproperty

assert property(p11);
cover property(p11);

property p12;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h1 && ALSU_if.red_op_A && ALSU_if.red_op_B) |->##2 (ALSU_if.out == (ALSU_if.INPUT_PRIORITY == "A" ? ^$past(ALSU_if.A,2) : ^$past(ALSU_if.B,2)));
endproperty

assert property(p12);
cover property(p12);

property p13;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h1 && ALSU_if.red_op_A && !ALSU_if.red_op_B) |->##2 (ALSU_if.out == ^$past(ALSU_if.A,2));
endproperty

assert property(p13);
cover property(p13);

property p14;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h1 && !ALSU_if.red_op_A && ALSU_if.red_op_B) |->##2 (ALSU_if.out == ^$past(ALSU_if.B,2));
endproperty

assert property(p14);
cover property(p14);

property p15;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h1 && !ALSU_if.red_op_A && !ALSU_if.red_op_B) |->##2 (ALSU_if.out == $past(ALSU_if.A,2) ^ $past(ALSU_if.B,2));
endproperty

assert property(p15);
cover property(p15);

property p16;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) &&
!ALSU_if.bypass_A && !ALSU_if.bypass_B && ALSU_if.opcode == 3'h3) |->##2 (ALSU_if.out == $past(ALSU_if.A,2)*$past(ALSU_if.B,2));
endproperty

assert property(p16);
cover property(p16);

property p17;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) && ALSU_if.bypass_A && ALSU_if.bypass_B) |->##2 (ALSU_if.out == (ALSU_if.INPUT_PRIORITY == "A" ? $past(ALSU_if.A,2) : $past(ALSU_if.B,2)));
endproperty

assert property(p17);
cover property(p17);

property p18;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) && ALSU_if.bypass_A && !ALSU_if.bypass_B) |->##2 (ALSU_if.out == $past(ALSU_if.A,2));
endproperty

assert property(p18);
cover property(p18);

property p19;
	@(posedge ALSU_if.clk) disable iff(ALSU_if.rst)
	(!((ALSU_if.opcode[1] && ALSU_if.opcode[2]) || 
((ALSU_if.red_op_A || ALSU_if.red_op_B) && (ALSU_if.opcode[1] || ALSU_if.opcode[2]))) && !ALSU_if.bypass_A && ALSU_if.bypass_B) |->##2 (ALSU_if.out == $past(ALSU_if.B,2));
endproperty

assert property(p19);
cover property(p19);
endmodule
