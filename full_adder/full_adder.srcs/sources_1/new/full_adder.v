`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2025 02:07:29 PM
// Design Name: 
// Module Name: full_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder(Cin, x, y, s, Cout);
input Cin, x, y;
output s, Cout;
xor (s, x, y, Cin);
and (z1, x, y),
    (z2, x, Cin),
    (z3, y, Cin);
or (Cout, z1, z2, z3);
endmodule
