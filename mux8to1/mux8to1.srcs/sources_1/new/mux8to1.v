`timescale 1ns / 1ps
module mux8to1(W, S, f);
  input [0:7] W;
  input [2:0] S;
  output f;
  wire [1:0] M;
  mux4to1 Mux1 (W[0:3], S[1:0], M[0]);
  mux4to1 Mux2 (W[4:7], S[1:0], M[1]);
  mux2to1 Mux5 (M[0], M[1], S[2], f); 
endmodule

module mux4to1 (H, I, J);
  input [0:3] H;
  input [1:0] I;
  output reg J;

  always @(H, I)
  case (I)
  0: J = H[0];
  1: J = H[1];
  2: J = H[2];
  3: J = H[3];
  endcase
endmodule

module mux2to1(a,b, sel, out);
    input a, b ,sel;
    output out;
    assign out = sel ? b : a;
endmodule