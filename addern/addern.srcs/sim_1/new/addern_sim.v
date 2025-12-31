`timescale 1ns / 1ps
module addern_sim;

reg carryin;
reg [3:0] X;
reg [3:0] Y;
wire [3:0] S;
wire carryout, overflow;
addern uut(carryin, X, Y, S, carryout, overflow);

initial
begin
    carryin = 0;
    X=4'b0100;
    Y=4'b0101;
    #1 
    X=4'b0001;
    #1
    Y=4'b0111;
end
endmodule
