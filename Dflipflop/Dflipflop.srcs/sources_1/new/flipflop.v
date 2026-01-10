`timescale 1ns / 1ps
module flipflop (D, Clock, Q);
input D, Clock;
output reg Q;
always @(posedge Clock)
Q = D;
endmodule
