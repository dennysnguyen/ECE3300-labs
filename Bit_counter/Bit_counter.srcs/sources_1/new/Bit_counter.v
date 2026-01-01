`timescale 1ns / 1ps

module Bit_counter(clk, reset, dataA, counterB, s, done);
    input clk, reset,s;
    input [7:0] dataA;
    output reg [3:0] counterB;
    output reg done;
    
    reg [1:0] state_reg, state_next;
    localparam [1:0] s1=2'b01, s2=2'b10, s3=2'b11;
    reg [7:0] registerA, registerA_next;
    reg [3:0] counterB_next;
    reg done_next;
    
    always@(posedge clk)
    begin
        if(reset)
            begin
                state_reg <= s1;
                registerA <= 0;
                counterB <= 0;
                done <= 0 ;
            end
        else
            begin
                state_reg <= state_next;
                registerA <= registerA_next;
                counterB <= counterB_next;
                done <= done_next;
            end
    end
            
    always @*
        begin
            state_next = state_reg;
            registerA_next = registerA;
            counterB_next = counterB;
            done_next = done;
            
            case(state_reg)
            s1:
                begin
                if (s==1)
                    begin
                        state_next=s2;
                        registerA_next = dataA;
                        counterB_next = 4'b0;
                        done_next=0;
                    end
                end
            s2:
                begin
                if(registerA == 0) 
                    begin
                        state_next=s3;
                    end
                else
                    begin
                         if(registerA[0] == 1'b1)
                        begin
                            counterB_next = counterB+1;
                        end
                            registerA_next = registerA >> 1;
                            state_next = s2;
                    end
                end
            s3: 
            begin
                done_next = 1;
                if (s == 0)
                begin
                    state_next = s1;
                    done_next = 0; 
                end
            end
            default:
            begin
                state_next = s1;
                done_next = 0;
            end
            endcase
        end
endmodule
