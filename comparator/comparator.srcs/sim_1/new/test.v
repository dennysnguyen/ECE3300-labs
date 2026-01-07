`timescale 1ns / 1ps

module comparator_sim;
reg [3:0] X,Y;
wire V, N, Z;

comparator uut(X, Y, V, N, Z);

initial begin
//add test cases here
    X=4'b0111;//7
    Y=4'b0111;//7
#1    
    X=4'b0010;//2
    Y=4'b0110;//6
#1
    X=4'b0111;//7
    Y=4'b0011;//3
#1
    X=4'b0111;//7
    Y=4'b1110;//-2
    
end
endmodule
