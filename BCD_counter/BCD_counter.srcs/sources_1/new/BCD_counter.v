`timescale 1ns / 1ps

module BCD_counter(Resetn,Clock,E,Q_t,Q_o);
    input Resetn;
    input Clock;
    input E;
    output [3:0] Q_t;
    output [3:0] Q_o;
    wire r;
    wire null;

    //instantiate ones digit
    digit_bcd_counter ones_counter (Resetn,Clock,E,r,Q_o);

    //instantiate tens digi
    digit_bcd_counter tens_counter (Resetn,Clock,r,null,Q_t);
endmodule


module digit_bcd_counter (
input Resetn,input Clock,input E,output r,output reg [3:0] Q);

    assign r = ((Q == 4'b1001) && E);

    always @(negedge Resetn, posedge Clock) begin
        if (!Resetn) 
        begin
            Q <= 4'b0000;
        end 
        else if (E) 
        begin
            if (Q == 4'd9) 
            begin
                Q <= 4'b0000;
            end 
            else 
            begin
                Q <= Q + 1;
            end
        end
    end
endmodule
