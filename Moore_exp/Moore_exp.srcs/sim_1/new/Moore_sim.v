`timescale 1ns / 1ps

module Mealy_sim;

    reg clk, reset, w;
    wire z;
edge_detect_mealy uut(clk, reset, w,z);

    
initial 
begin
    clk = 0;
    reset = 0;
    w = 0;
#1
    reset = 1; clk = ~clk;
#1
    reset = 0; clk = ~clk;
#1 
    clk = ~clk;
#0.5
    w = 1;
#0.5
    clk = ~clk;
repeat (10) #1 clk = ~clk;

end
endmodule
