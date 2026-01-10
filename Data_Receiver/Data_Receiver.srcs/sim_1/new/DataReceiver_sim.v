`timescale 1ns / 1ps

module DataReceiver_sim();

    DataReceiver uut(serial,Clock,D_out,data_valid,parity_error);

    reg serial;
    reg Clock;
    wire [7:0] D_out;
    wire data_valid;
    wire parity_error;
    

    initial 
    begin
        Clock = 0;
        repeat(1000)
            #1 Clock = ~Clock;
    end


    initial 
    begin
        serial = 0;
        #5;
        
        // b = 00100000
        @(posedge Clock) serial = 1'b0; 
        @(posedge Clock) serial = 1'b0;
        @(posedge Clock) serial = 1'b0;
        @(posedge Clock) serial = 1'b0;
        @(posedge Clock) serial = 1'b0;
        @(posedge Clock) serial = 1'b1;
        @(posedge Clock) serial = 1'b0;
        @(posedge Clock) serial = 1'b0;
        @(posedge Clock) serial = 1'b0;//parity bit correct
        
        @(posedge Clock) serial = 0;
        @(posedge Clock) serial = 0;
        @(posedge Clock) serial = 0;
        
        //b = 00010100
        @(posedge Clock) serial = 1'b0;
        @(posedge Clock) serial = 1'b0;
        @(posedge Clock) serial = 1'b1;
        @(posedge Clock) serial = 1'b0;
        @(posedge Clock) serial = 1'b1; 
        @(posedge Clock) serial = 1'b0;
        @(posedge Clock) serial = 1'b0;
        @(posedge Clock) serial = 1'b0;
        @(posedge Clock) serial = 1'b1; //wrong parity bit
        
        @(posedge Clock) serial = 0;
        @(posedge Clock) serial = 0;
        @(posedge Clock) serial = 0;
    end

endmodule