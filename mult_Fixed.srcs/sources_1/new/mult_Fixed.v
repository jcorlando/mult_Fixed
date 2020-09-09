`timescale 1ns / 1ps

module mult_Fixed # ( parameter WI1 = 4, WF1 = 4,    // input 1 integer and fraction bits
                                WI2 = 4, WF2 = 4,    // input 2 integer and fraction bits
                             WIO = WI1 + WI2 - 1,    // output integer bits
                             WFO = WF1 + WF2 + 1 )   // output fraction bits
(
    input RESET,
    input signed [WI1 + WF1 - 1 : 0] in1,            // Multiplicand
    input signed [WI2 + WF2 - 1 : 0] in2,            // Multiplier
    output reg signed [WIO + WFO - 1 : 0] out        // Output
);
    // Local Parameters
    localparam WIP = WI1 + WI2 - 1;             // Precise integer bits
    localparam WFP = WF1 + WF2 + 1;             // Precise fraction bits
    // Compute the full precision product
    wire signed [WIP + WFP - 1 : 0] fullPreciseProduct = in1 * in2;                   // Precise product
    wire [WIP - 1 : 0] precise_int_bits  = fullPreciseProduct[WIP + WFP - 1 : WFP];   // Just the integer  bits of fullPreciseProduct
    wire [WFP - 1 : 0] precise_frac_bits = fullPreciseProduct[WFP - 1 : 0];           // Just the fraction bits of fullPreciseProduct
    wire signed [WIO + WFO - 1 : 0] finalProduct;
    
    always @ (*)
    begin
        if(WIO == WI1 + WI2 - 1);
            // Dont do anything
        else if(WIO > WI1 + WI2 - 1);
            // sign-extend 
        else; // WIO < WI1 + WI2 - 1
        
        if(WFO == WF1 + WF2 + 1);
        else if(WFO > WF1 + WF2 + 1);
        else; // WFO < WF1 + WF2 + 1
    end
    
    
    
    
    
endmodule











