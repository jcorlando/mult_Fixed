`timescale 1ns / 1ps

module tb_mult_Fixed;
// parameters
parameter WI1 = 5, WF1 = 3,     // input 1 integer and fraction bits
          WI2 = 3, WF2 = 6,     // input 2 integer and fraction bits
          WIO = WI1 + WI2 - 1,  // output  integer and fraction bits
          WFO = WF1 + WF2 + 1;  // output  integer and fraction bits
//Inputs
reg RESET;
reg signed [WI1 + WF1 - 1 : 0] in1;
reg signed [WI2 + WF2 - 1 : 0] in2;
//Outputs
wire signed [WIO + WFO - 1 : 0] out;
//Instantiate DUT
mult_Fixed #( .WI1(WI1), .WF1(WF1), .WI2(WI2), .WF2(WF2), .WIO(WIO) )
        DUT( .RESET(RESET), .in1(in1), .in2(in2), .out(out) );

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

