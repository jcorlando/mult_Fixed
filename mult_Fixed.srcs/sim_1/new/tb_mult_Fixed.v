`timescale 1ns / 1ps

module tb_mult_Fixed;
// parameters
parameter WI1 = 3, WF1 = 1,     // input 1 integer and fraction bits
          WI2 = 2, WF2 = 2,     // input 2 integer and fraction bits
          WIO = WI1 + WI2 - 1,  // output  integer and fraction bits
          WFO = WF1 + WF2 + 1;  // output  integer and fraction bits
//Inputs
reg RESET;
reg CLK;
reg signed [WI1 + WF1 - 1 : 0] in1;
reg signed [WI2 + WF2 - 1 : 0] in2;
//Outputs
wire signed [WIO + WFO - 1 : 0] out;
// Clock generation
initial CLK <= 0;
always #50 CLK <= ~CLK;
//Instantiate DUT
mult_Fixed #( .WI1(WI1), .WF1(WF1), .WI2(WI2), .WF2(WF2), .WIO(WIO) )
        DUT( .RESET(RESET), .CLK(CLK), .in1(in1), .in2(in2), .out(out) );

initial
begin
    RESET <= 0;
    in1 <= 4'b1_01_1;
    in2 <= 4'b0_0_10;
    @(posedge CLK);
    @(posedge CLK);
    in1 <= 4'b1_11_0;
    in2 <= 4'b0_0_11;
    @(posedge CLK);
end

endmodule









