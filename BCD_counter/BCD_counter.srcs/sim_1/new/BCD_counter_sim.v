`timescale 1ns / 1ps


module BCD_counter_sim;

BCD_counter uut(Resetn,Clock,E,Q_t,Q_o);
    reg Clock;
    reg Resetn;
    reg E;
    
    wire [3:0] Q_t;
    wire [3:0] Q_o;

initial begin
    Clock = 0;
    forever #0.5 Clock = ~Clock;
end
    
initial begin
    Resetn = 0; 
    E = 0;

#5;
    Resetn = 1;
#5
    E = 1;
        
#100;

    $finish;
end

endmodule
