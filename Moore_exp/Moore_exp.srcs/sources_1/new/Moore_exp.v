`timescale 1ns / 1ps
module edge_detect_moore (input wire clk, reset, w, output reg z);
localparam [1:0] zero=2'b00, one=2'b01, two=2'b10, three=2'b11;
reg [1:0] state_reg, state_next;

always @(posedge clk, posedge reset)
    if (reset)
        state_reg<=zero;
    else
    state_reg<=state_next;
    
    
always@*
    begin
        state_next=state_reg;
        z=1'b0;
        case (state_reg)
        zero:
            begin
                if (w)
                    state_next=three;
                else
                    state_next=two;
            end
        one:
            begin
                if (w)
                    state_next=zero;
                else
                    state_next=one;
            end
        two:
            begin
                if (w)
                    state_next=zero;
                else
                    state_next=three;
            end
        three:
            begin
                z=1'b1;
                if (w)
                    state_next=one;
                else
                    state_next=two;
            end
        default: state_next=zero;
        endcase
    end
endmodule
