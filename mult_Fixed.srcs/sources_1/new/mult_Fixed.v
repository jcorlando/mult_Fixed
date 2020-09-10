`timescale 1ns / 1ps

module mult_Fixed # ( parameter WI1 = 4, WF1 = 4,    // input 1 integer and fraction bits
                                WI2 = 4, WF2 = 4,    // input 2 integer and fraction bits
                             WIO = WI1 + WI2 - 1,    // output integer bits
                             WFO = WF1 + WF2 + 1 )   // output fraction bits
(
    input RESET,
    input signed [WI1 + WF1 - 1 : 0] in1,            // Multiplicand
    input signed [WI2 + WF2 - 1 : 0] in2,            // Multiplier
    output signed [WIO + WFO - 1 : 0] out            // Output
);
    // Local Parameters
    localparam WIP = WI1 + WI2 - 1;             // local parameters for Precise integer bits
    localparam WFP = WF1 + WF2 + 1;             // local parameters for Precise fraction bits
    
    // Temporary registers for output
    reg [WIO - 1 : 0] temp_out_int_bits;
    reg [WFO - 1 : 0] temp_out_frac_bits;
    
    // in1 and in2 Sign bits
    wire in1_Sign = in1[WI1 + WF1 - 1];        // in1 Sign bit
    wire in2_Sign = in2[WI2 + WF2 - 1];        // in2 Sign bit
    
    // Compute the full precision product
    wire signed [WIP + WFP - 1 : 0] fullPreciseProduct = in1 * in2;                   // Precise product
    
    // Store Integer bits and Fraction bits
    wire [WIP - 1 : 0] precise_int_bits  = fullPreciseProduct[WIP + WFP - 1 : WFP];   // Just the integer  bits of fullPreciseProduct
    wire [WFP - 1 : 0] precise_frac_bits = fullPreciseProduct[WFP - 1 : 0];           // Just the fraction bits of fullPreciseProduct
    
    // Int temp wire
    //wire [WIP - WIO - 2 : 0] Int_Temp = precise_int_bits[WIP - WIO - 2 : WIO - 1];   // Store integer bits that might get truncated
    
    // Wire for final output
    wire signed [WIO + WFO - 1 : 0] finalProduct;
    
    always @ (*)
    begin
        // Logic for integer bits
        if( WIO == WI1 + WI2 - 1 )  // Assign precise bits to temp_out_int_bits
            temp_out_int_bits <= precise_int_bits;
        else if( WIO > WI1 + WI2 - 1 )  // sign-extend
            temp_out_int_bits <= {{ (WIP - WIO){precise_int_bits[WIP - 1]}} , precise_int_bits };
        else        // WIO < WI1 + WI2 - 1;
            temp_out_int_bits <= precise_int_bits[ WIP - 1 : (WIP - 1) - WIO ];
        
        
        // Logic for fraction bits
        if( WFO == WF1 + WF2 + 1 ) // Assign precise bits to temp_out_int_bits
            temp_out_frac_bits <= precise_frac_bits;
        else if( WFO > WF1 + WF2 + 1 )  // Append zeros
            temp_out_frac_bits <= { precise_frac_bits , { (WFP - WFO){1'b0}} };
        else       // WFO < WF1 + WF2 + 1; Truncate bits
            temp_out_frac_bits <= precise_frac_bits[WFP - 1 : WFP - 1 - WFO];
    end
    
    assign out = {temp_out_int_bits, temp_out_frac_bits};
    
endmodule











