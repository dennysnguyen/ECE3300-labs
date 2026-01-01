`timescale 1ns / 1ps
module Bit_counter_sim;
reg clock, reset, s;
reg [7:0] dataA;
wire done;
wire [3:0] counterB;
Bit_counter uut(clock, reset, dataA, counterB, s, done);

initial 
        clock = 0;
    always 
        #1 clock = ~clock;
        
        
initial begin
        reset = 1;
        s = 0;
        dataA = 8'h00;

        #3;
        reset = 0;
        

        @(posedge clock); 

        dataA = 8'b10101101;
        s = 1;

        @(posedge clock);
        s = 0;


        wait (done == 1'b1);

        #10;

        dataA = 8'b11110001; 
        s = 1;
        
        @(posedge clock);
        s = 0;

        wait (done == 1'b1);
       

        #100;
end
endmodule
