`timescale 1ns / 1ps

module sim;

eight_bit_PASR uut(R, L, w, Clock, Q);
reg [7:0] R;
reg L, w, Clock;
wire [7:0] Q;


initial begin
    Clock = 0;
end
always #1 Clock = ~Clock;

initial begin
    L = 1;
    R = 8'b01001000; //ASCII for H
    w = 0;

//01101001 ASCII for i
#2;
    L = 0;          
    w = 1;//bit 0
#2;
    L = 0;          
    w = 0;//bit 1
#2;
    L = 0;          
    w = 0;//bit 2
#2;
    L = 0;          
    w = 1;//bit 3
#2;
    L = 0;          
    w = 0;//bit 4
#2;
    L = 0;
    w = 1;//bit 5
#2;
    L = 0;          
    w = 1;//bit 6
#2;
    L = 0;
    w = 0;//bit 7
#2;
    $finish;//stop shifting
end

endmodule

