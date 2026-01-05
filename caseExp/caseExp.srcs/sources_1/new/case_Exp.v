`timescale 1ns / 1ps
module mux4to1 (W, S, f);
  input [0:3] W;
  input [1:0] S;
  output reg f;
  always @(W, S)
  begin
    case (S)
        'b00: f = W[0];
        'b01: f = W[1];
        'b10: f = W[2];
        'b11: f = W[3];
    endcase
  end
endmodule