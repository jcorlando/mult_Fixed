`timescale 1ns / 1ps

module tb_mult_Fixed;
// parameters
parameter WI1 = 5, WF1 = 3,     // input 1 integer and fraction bits; 8 bits
          WI2 = 3, WF2 = 6,     // input 2 integer and fraction bits; 9 bits
          WIO = WI1 + WI2 - 1,  // output  integer and fraction bits; WI1 + WI2 - 1
          WFO = WF1 + WF2 + 1;  // output  integer and fraction bits; WF1 + WF2 + 1
// Local Parameters
localparam WIP = WI1 + WI2 - 1;
localparam WFP = WF1 + WF2 + 1;
//Inputs
reg RESET;
reg signed [WI1 + WF1 - 1 : 0] in1;
reg signed [WI2 + WF2 - 1 : 0] in2;
//Outputs
wire signed [WIO + WFO - 1 : 0] out;
wire OVF;
//Instantiate DUT
mult_Fixed #( .WI1(WI1), .WF1(WF1), .WI2(WI2), .WF2(WF2), .WIO(WIO), .WFO(WFO) )
        DUT( .RESET(RESET), .in1(in1), .in2(in2), .out(out), .OVF(OVF) );
        wire signed [WIP + WFP - 1 : 0] fullPreciseProduct = DUT.fullPreciseProduct;    // These are all tests
        wire [WIP - 1 : 0] precise_int_bits  = DUT.precise_int_bits;                    // These are all tests
        wire [WFP - 1 : 0] precise_frac_bits = DUT.precise_frac_bits;                   // These are all tests
        wire [WIO - 1 : 0] temp_out_int_bits = DUT.temp_out_int_bits;                   // These are all tests
        wire [WFO - 1 : 0] temp_out_frac_bits = DUT.temp_out_frac_bits;                 // These are all tests
        wire [WIP - WIO - 1 : 0] tmp = DUT.tmp;                                         // These are all tests
initial
begin
    RESET <= 0;
    in1 <= 8'b1_0110_110;
    in2 <= 9'b0_01_110011;
    # 150;
    in1 <= 8'b0_1011_111;
    in2 <= 9'b1_11_100110;
    # 150;
    in1 <= 8'b0_0101_100;
    in2 <= 9'b0_10_100111;
    # 150;
    RESET <= 1;
    # 150;
    RESET <= 0;
    in1 <= 8'b1_1111_001;
    in2 <= 9'b1_01_000011;
    # 150;
    in1 <= 8'b0_0101_100;
    in2 <= 9'b0_01_100111;
end

endmodule

