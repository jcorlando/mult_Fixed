`timescale 1ns / 1ps

module mult_Fixed # (parameter WI1 = 4, WF1 = 4,   // input 1 integer and fraction bits
                               WI2 = 4, WF2 = 4,   // input 2 integer and fraction bits
         WIO = WI1 + WI2 - 1, WFO = WF1 + WF2 + 1) // output  integer and fraction bits
(
    input RESET,
    input CLK,
    input signed [WI1 + WF1 - 1 : 0] in1,     // Multiplicand
    input signed [WI2 + WF2 - 1 : 0] in2,     // Multiplier
    output reg signed [WIO + WFO - 1 : 0] out // Output
);
    wire [7 : 0] scale_Factor = WI1 > WI2 ? WI1 : WI2;
    wire signed [WI1 + WF1 - 1 : 0] in1_Temp;
    wire signed [WI2 + WF2 - 1 : 0] in2_Temp;
    
    always @ (posedge CLK)
    begin
        out <= in1*in2;
    end
    
    
    
endmodule











