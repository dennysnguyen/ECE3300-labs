`timescale 1ns / 1ps
module DLatch(D, En, Q);
input D;
input En;
output Q;
reg Q;
always @(D or En)
if (En)
begin
Q = D;
end
endmodule