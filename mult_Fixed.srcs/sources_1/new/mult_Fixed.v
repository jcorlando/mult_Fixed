`timescale 1ns / 1ps

module mult_Fixed # ( parameter WI1 = 4, WF1 = 4,    // input 1 integer and fraction bits
                                WI2 = 4, WF2 = 4,    // input 2 integer and fraction bits
                             WIO = WI1 + WI2 - 1,    // output integer bits
                             WFO = WF1 + WF2 + 1 )   // output fraction bits
(
    input RESET,
    input signed [WI1 + WF1 - 1 : 0] in1,           // Multiplicand
    input signed [WI2 + WF2 - 1 : 0] in2,           // Multiplier
    output reg signed [WIO + WFO - 1 : 0] out       // Output
);
    // Compute the full precision product
    wire signed [WIO + WFO - 1 : 0] fullPreciseProduct = in1 * in2;                   // Precise product
    wire [WIO - 1 : 0] precise_int_bits  = fullPreciseProduct[WIO + WFO - 1 : WFO];   // Just the integer  bits of fullPreciseProduct
    wire [WFO - 1 : 0] precise_frac_bits = fullPreciseProduct[WFO - 1 : 0];           // Just the fraction bits of fullPreciseProduct
    wire signed [WIO + WFO - 1 : 0] finalProduct;
    
    always @ (*)
    begin
        if( (WIO == WI1 + WI2) && (WFO == WF1 + WF2) )
        begin
            
        end
        else if( (WIO > WI1 + WI2) && (WFO > WF1 + WF2) )
        begin
            
        end
        else if( (WIO < WI1 + WI2) && (WFO < WF1 + WF2) )
        begin
            
        end
        else
        begin
            
        end
    end
    
    
endmodule











