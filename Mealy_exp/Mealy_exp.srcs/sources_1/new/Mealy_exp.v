`timescale 1ns / 1ps
module edge_detect_mealy (input wire clk, reset, w,output reg z);
    localparam A=1'b0, B=1'b1;
    reg state_reg, state_next;
    always @(posedge clk, posedge reset)
        if (reset)
            state_reg<=A;
        else
            state_reg<=state_next;
            
    always@*
        begin
            state_next=state_reg;
            z=1'b0;
            case (state_reg)
                A:
                    if (w)
                        begin
                            z=1'b0;//this change is immediate
                            state_next=B;
                        end
                B:
                    if (w)
                        begin
                            z = 1'b1;
                            state_next=B;
                        end
                    else
                        begin
                            z = 1'b0;
                            state_next=A;
                        end
                default:
                    state_next=A;
            endcase
        end
endmodule
