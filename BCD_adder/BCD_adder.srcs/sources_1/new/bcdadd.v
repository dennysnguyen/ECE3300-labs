`timescale 1ns / 1ps

module bcdadd(Cin, X, Y, S, Cout);
    input Cin;
    input [3:0] X,Y;
    output reg [3:0] S;
    output reg Cout;
    reg [4:0] Z;
    
    always@(X,Y,Cin)
    begin
        Z=X+Y+Cin;
        if (Z < 10)
            {Cout,S} = Z;
        else
            {Cout,S} = Z + 6;
    end        
endmodule
