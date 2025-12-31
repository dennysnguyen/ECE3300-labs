`timescale 1ns / 1ps

module eight_bit_PASR(R, L, w, Clock, Q);
  input [7:0] R;
  input L, w, Clock;
  output reg [7:0] Q;

  always @(posedge Clock)
     if (L)
         Q <= R;
    else
         begin
            Q[0] <= Q[1]; //non-blocking statements, will be introduced next
            Q[1] <= Q[2];
            Q[2] <= Q[3];
            Q[3] <= Q[4];
            Q[4] <= Q[5];
            Q[5] <= Q[6];
            Q[6] <= Q[7];
            Q[7] <= w;
        end
endmodule 
