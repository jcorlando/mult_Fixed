`timescale 1ns / 1ps

module mult_Fixed # (parameter WI1 = 16, WF1 = 16, // input 1 integer and fraction bits
                               WI2 = 16, WF2 = 16, // input 2 integer and fraction bits
          WIO = WI1 + WI2 -1, WFO = WF1 + WF2 + 1) // output  integer and fraction bits
(
    input RESET,
    input CLK,
    input signed [WI1 + WF1 - 1 : 0] in1,
    input signed [WI2 + WF2 - 1 : 0] in2,
    output signed [WIO + WFO - 1 : 0] out
);



endmodule


