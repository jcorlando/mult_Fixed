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
    
    
    always @ (*)
    begin
        if(RESET) out <= 0;
        else out <= in1*in2;
    end
    
endmodule











