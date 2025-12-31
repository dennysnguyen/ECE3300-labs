`timescale 1ns / 1ps

module BCD_Adder_Sim;
reg Cin;
reg [3:0] X,Y;
wire [3:0] S;
wire Cout;
bcdadd uut(.Cin(Cin), .X(X), .Y(Y), .S(S), .Cout(Cout));

initial begin
Cin = 0;
   X = 4'b1001;//9
   Y = 4'b0011;//3
#1 X = 4'b0011;//3
   Y = 4'b0010;//2
end
endmodule
