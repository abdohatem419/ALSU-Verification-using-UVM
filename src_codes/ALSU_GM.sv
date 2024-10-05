module ALSU_golden_model(ALSU_interface.DUT_GOLD ALSU_if);
/*Internal signals*/
reg  red_op_A_reg, red_op_B_reg, bypass_A_reg, bypass_B_reg, direction_reg, serial_in_reg;
reg [2:0] opcode_reg;
reg signed [2:0] A_reg, B_reg;
reg signed [1:0] Cin_reg;
/*Parameters definitions*/
parameter INPUT_PRIORITY ="A" ;
parameter FULL_ADDER="ON";


always@(posedge ALSU_if.clk or posedge ALSU_if.rst)begin
    if(ALSU_if.rst)begin
        serial_in_reg<=0;
        red_op_A_reg <=0;
        red_op_B_reg <=0;
        bypass_A_reg <=0;
        bypass_B_reg <=0;
        direction_reg<=0;
        A_reg        <=0;
        B_reg        <=0;   
        opcode_reg   <=0;
        Cin_reg      <=0;
    end
    else begin
        serial_in_reg<=ALSU_if.serial_in;
        red_op_A_reg <=ALSU_if.red_op_A;
        red_op_B_reg <=ALSU_if.red_op_B;
        bypass_A_reg <=ALSU_if.bypass_A;
        bypass_B_reg <=ALSU_if.bypass_B;
        direction_reg<=ALSU_if.direction;
        A_reg        <=ALSU_if.A;
        B_reg        <=ALSU_if.B;   
        opcode_reg   <=ALSU_if.opcode;
        Cin_reg      <=ALSU_if.cin;
    end
end

/*main functionality*/
always@(posedge ALSU_if.clk or posedge ALSU_if.rst)begin
    if(ALSU_if.rst)begin
        ALSU_if.leds_g         <=0;
        ALSU_if.out_g          <=0;
    end
    else begin
        if((opcode_reg==3'b110||opcode_reg==3'b111)||((red_op_A_reg==1||red_op_B_reg==1)&&(opcode_reg!=3'b000&&opcode_reg!=3'b001)))begin
            ALSU_if.leds_g<=ALSU_if.leds_g^16'hFFFF;
            ALSU_if.out_g<=0;
        end
        else if(bypass_A_reg||bypass_B_reg) begin
            ALSU_if.leds_g <= 0;
            if(bypass_A_reg&&bypass_B_reg)begin
                if(INPUT_PRIORITY == "A" )begin
                    ALSU_if.out_g<=A_reg;
                end
                else if(INPUT_PRIORITY == "B")begin
                    ALSU_if.out_g<=B_reg;
                end
            end
            else if(bypass_A_reg)begin
                ALSU_if.out_g<=A_reg;
            end
            else if(bypass_B_reg)begin
                ALSU_if.out_g<=B_reg;
            end
    end
    else begin
        ALSU_if.leds_g <= 0;
        case (opcode_reg)
            3'b000:begin
                if(red_op_A_reg||red_op_B_reg)begin
                    if(red_op_A_reg&&red_op_B_reg)begin
                        if(INPUT_PRIORITY=="A")ALSU_if.out_g<=|A_reg;
                        else if(INPUT_PRIORITY=="B")ALSU_if.out_g<=|B_reg;
                    end
                     else if(red_op_A_reg)ALSU_if.out_g<=|A_reg;
                     else if(red_op_B_reg)ALSU_if.out_g<=|B_reg;
                end
                else begin
                    ALSU_if.out_g<=A_reg|B_reg;
                end
            end
            3'b001:begin
                if(red_op_A_reg||red_op_B_reg)begin
                    if(red_op_A_reg&&red_op_B_reg)begin
                        if(INPUT_PRIORITY=="A")ALSU_if.out_g<=^A_reg;
                        else if(INPUT_PRIORITY=="B")ALSU_if.out_g<=^B_reg;
                    end
                     else if(red_op_A_reg)ALSU_if.out_g<=^A_reg;
                     else if(red_op_B_reg)ALSU_if.out_g<=^B_reg;
                end
                else begin
                    ALSU_if.out_g<=A_reg^B_reg;
                end
            end
            3'b010:begin
                     if(FULL_ADDER=="ON")begin
                        ALSU_if.out_g<=A_reg+B_reg+Cin_reg;
                     end
                     else if(FULL_ADDER=="OFF")begin
                        ALSU_if.out_g<=A_reg+B_reg;
                     end   
            end
            3'b011:begin
                ALSU_if.out_g<=A_reg*B_reg;
            end
            3'b100:begin
                     if(direction_reg)begin
                        ALSU_if.out_g<={ALSU_if.out_g[4:0],serial_in_reg};
                     end
                     else begin
                        ALSU_if.out_g<={serial_in_reg,ALSU_if.out_g[5:1]};
                     end
            end
            3'b101:begin
                     if(direction_reg)begin
                        ALSU_if.out_g<={ALSU_if.out_g[4:0],ALSU_if.out_g[5]};
                     end
                     else begin
                        ALSU_if.out_g<={ALSU_if.out_g[0],ALSU_if.out_g[5:1]};
                     end
            end 
        endcase
        
    end
end
end
endmodule