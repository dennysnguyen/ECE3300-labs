`timescale 1ns / 1ps

module DataReceiver(serial,Clock,D_out,data_valid,parity_error);
    input serial;
    input Clock;
    output reg [7:0] D_out;
    output reg data_valid;
    output reg parity_error;

    wire [3:0] C;
    wire shift_enable;
    wire reset;
    wire i;
    wire calculated_parity;
    wire [7:0] data;
    
    
    assign shift_enable = 8; 
    assign reset = 0;
    assign i = shift_enable;
    
    always@(posedge Clock)
    begin
        if (C == 4'd8)
        begin
            if (serial != calculated_parity)
                parity_error <= 1'b1;
            else
                parity_error <= 1'b0;
            
            D_out <= data;
            data_valid <= 1'b1;
        end
        else
        begin
            data_valid <= 1'b0;
            if (C == 4'd0)
                parity_error <= 1'b0;
        end
    end

    Counter myCounter (.Clock(Clock),.C(C));
    ShiftReg myShiftReg (.Clock(Clock),.shift_enable(shift_enable),.sin(serial),.Q(data));
    OdddParityCheck myParityCheck (.w(i),.reset(reset),.clock(Clock),.p(calculated_parity));
    
endmodule


module ShiftReg(Clock,shift_enable,sin,Q);
    input Clock;
    input shift_enable;
    input sin;
    output reg [7:0] Q;

    initial
    begin
        Q = 8'd0;
    end

    always@(posedge Clock)
    begin
        if (shift_enable)
        begin

            Q[7] <= sin;
            Q[6] <= Q[7];
            Q[5] <= Q[6];
            Q[4] <= Q[5];
            Q[3] <= Q[4];
            Q[2] <= Q[3];
            Q[1] <= Q[2];
            Q[0] <= Q[1];
        end
    end
endmodule

module OdddParityCheck(w,reset,clock,p);
    input w;
    input reset;
    input clock;
    output reg p;

    localparam S_even = 1'b0, S_odd=1'b1;
    reg state_reg, state_next;
    
    always@(posedge clock)
    begin
        if (reset == 1'b0)
            state_reg <= S_even;
        else
            state_reg <= state_next;
    end
    
    always@*
    begin
        state_next = state_reg;
        case(state_reg)
        S_even:
        begin
            p = 1'b0;
            if (w)
                state_next = S_odd;
        end
        S_odd:
        begin
            p = 1'b1;
            if (w)
                state_next = S_even;
        end 
        default: 
        begin
            p = 1'b0;
            state_next = S_even;
        end
        endcase
    end
endmodule


module Counter(Clock,C);
    input Clock;
    output reg [3:0] C;
    
    initial
    begin
        C = 4'd0;
    end
    
    always@(posedge Clock)
    begin
        if (C == 4'd8)
            C <= 4'd0;
        else
            C <= C + 1'b1;
    end
endmodule