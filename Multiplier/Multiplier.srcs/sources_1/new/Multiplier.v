`timescale 1ns / 1ps
module Multiplier(clock, reset, command, dataA, dataB, product, done);
localparam n=4;
input clock, reset, command;
input [n-1:0] dataA;
input [n-1:0] dataB;
output reg [2*n-1:0] product;
output reg done;
reg [1:0] state_reg;
localparam [1:0] s1=2'b01, s2=2'b10, s3=2'b11;
reg [1:0] state_next;
reg [n-1:0] registerB, registerB_next;
reg [2*n-1:0] registerA, registerA_next;
reg [2*n-1:0] product_next;
reg done_next;

always @(posedge clock)
if (reset)
begin
state_reg <= s1;
product<=0;
registerA<=0;
registerB<=0;
done=0;
end
else
begin
state_reg <= state_next;
product<=product_next;
registerA<=registerA_next;
registerB<=registerB_next;
done<= done_next;
end

always @*
begin
state_next = state_reg;
product_next=product;
registerA_next=registerA;
registerB_next=registerB;
done_next=done;
case (state_reg)
s1:
begin
if (command==1)
begin
state_next=s2;
done_next=0;
end
else
begin
registerA_next ={4'b0, dataA};
registerB_next =dataB;
end
end
s2:
begin
if (registerB==0)
begin
state_next=s3;
end
else
begin
if (registerB_next[0]==1'b1)
begin
product_next<= product + registerA;
end
else //can be omitted
begin
product_next = product;
end
end
registerA_next=registerA<<1;
registerB_next=registerB>>1;
end
s3:
begin
done_next=1;
if (command==0)
state_next=s1;
end
default:
begin
state_next = s1;
done_next=0;
end
endcase
end

endmodule
