`timescale 1ns / 1ps

module mult_Fixed # ( parameter WI1 = 4, WF1 = 4,    // input 1 integer and fraction bits
                                WI2 = 4, WF2 = 4,    // input 2 integer and fraction bits
                             WIO = WI1 + WI2 - 1,    // output integer bits
                             WFO = WF1 + WF2 + 1 )   // output fraction bits
(
    input RESET,
    input signed [WI1 + WF1 - 1 : 0] in1,            // Multiplicand
    input signed [WI2 + WF2 - 1 : 0] in2,            // Multiplier
    output signed [WIO + WFO - 1 : 0] out,           // Output
    output reg OVF                                   // Overflow Flag
);
    // Local Parameters
    localparam WIP = WI1 + WI2 - 1;             // local parameters for Precise integer bits
    localparam WFP = WF1 + WF2 + 1;             // local parameters for Precise fraction bits
    
    // Temporary registers for output
    reg [WIO - 1 : 0] temp_out_int_bits;
    reg [WFO - 1 : 0] temp_out_frac_bits;
    
    // Compute the full precision product
    wire signed [WIP + WFP - 1 : 0] fullPreciseProduct = in1 * in2;     // Precise product
    
    // fullPreciseProduct Sign bit
    wire sign_Bit = fullPreciseProduct[WIP + WFP - 1];                  // fullPreciseProduct Sign bit
    
    // Store Integer bits and Fraction bits
    wire [WIP - 1 : 0] precise_int_bits  = fullPreciseProduct[WIP + WFP - 1 : WFP];   // Just the integer  bits of fullPreciseProduct
    wire [WFP - 1 : 0] precise_frac_bits = fullPreciseProduct[WFP - 1 : 0];           // Just the fraction bits of fullPreciseProduct
    
    // Int temp wire
    reg [WIP - WIO - 1 : 0] tmp;   // Truncated integer bits minus the sign bit
    
    initial OVF <= 0;       // Set intial state of overflow = 0
    
    always @ (*)
    begin
        if(RESET) begin temp_out_int_bits <= 0; temp_out_frac_bits <= 0; end  // asynchronous RESET
        else
        begin
            // Logic for integer bits
            if( WIO == WI1 + WI2 - 1 )  // Assign precise bits to temp_out_int_bits
                temp_out_int_bits <= precise_int_bits;
            else if( WIO > WI1 + WI2 - 1 )  // sign-extend
                temp_out_int_bits <= {{ (WIO - WIP){precise_int_bits[WIP - 1]}} , precise_int_bits };
            else        // WIO < WI1 + WI2 - 1;
            begin
                tmp <= precise_int_bits[WIP - 1 : WIP - (WIP - WIO)];
                temp_out_int_bits <= { precise_int_bits[WIP - 1], precise_int_bits[WIO - 2 : 0] };
            end
            
            
            // Logic for fraction bits
            if( WFO == WF1 + WF2 + 1 ) // Assign precise bits to temp_out_frac_bits
                temp_out_frac_bits <= precise_frac_bits;
            else if( WFO > WF1 + WF2 + 1 )  // Append zeros
                temp_out_frac_bits <= { precise_frac_bits , { (WFP - WFO){1'b0}} };
            else       // WFO < WF1 + WF2 + 1; Truncate bits
                temp_out_frac_bits <= precise_frac_bits[WFP - 1 : WFP - 1 - WFO];
        end
    end
    
    assign out = {temp_out_int_bits, temp_out_frac_bits};
    
endmodule











