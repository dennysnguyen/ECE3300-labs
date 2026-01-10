`timescale 1ns / 1ps

module digital_clock(clk, resetSW, segments, AN);
    input clk, resetSW;
    output [6:0] segments;
    output reg[7:0] AN;
    
    wire one_second_clock;
    wire POV_clock;
    wire [1:0] display_select;
    wire [3:0] digit_display;
    
    system_Clock clock_gen(clk, resetSW, one_second_clock, POV_clock);
    
    display_selector_counter two_bit_count(resetSW, POV_clock, display_select);
    
    time_counter t_counter(resetSW,one_second_clock, display_select, digit_display);
    
    seven_seg_decoder decoder(digit_display, segments);
    
    //400 hz show
    always @(*)
    begin
        if (resetSW)
        begin
            AN = 8'b11111111; // All off
        end
        else
        begin
            case(display_select)
                2'b00:  AN = 8'b11111110; // AN0 sec_ones
                2'b01:  AN = 8'b11111101; // AN1 sec_tens
                2'b10:  AN = 8'b11111011; // AN2 min_ones
                2'b11:  AN = 8'b11110111; // AN3 min_tens
                default: AN = 8'b11111111; // All off
            endcase
        end
    end
endmodule

//clock generator module
module system_Clock(clk, resetSW, one_second_clock, POV_clock);
    input clk;
    input resetSW;
    output reg one_second_clock = 0;
    output reg POV_clock = 0;

    reg [26:0] counter_1s;
    reg [16:0] counter_pov;
    
    integer MAX_COUNT_1S = 50_000_000;//1hz
    integer MAX_COUNT_POV = 125_000;//400hz

    always @ (posedge clk or posedge resetSW)
    begin
        if (resetSW)
        begin
            counter_1s <= 0;
            counter_pov <= 0;
            one_second_clock <= 0;
            POV_clock <= 0;
        end
        else
        begin
            // 1 second
            if (counter_1s == MAX_COUNT_1S - 1)
            begin
                one_second_clock <= ~one_second_clock;
                counter_1s <= 0;
            end
            else
            begin
                counter_1s <= counter_1s + 1;
            end
            
            // 400 hz
            if (counter_pov == MAX_COUNT_POV - 1)
            begin
                POV_clock <= ~POV_clock;
                counter_pov <= 0;   
            end
            else
            begin
                counter_pov <= counter_pov + 1;
            end
        end
    end
endmodule

//time keep & digit selection
module time_counter(resetSW,one_second_clock, display_select,
                    digit_display);
    input resetSW,one_second_clock;
    input [1:0] display_select;
    output reg [3:0] digit_display;
    
    
    reg [3:0] min_tens = 0;
    reg [3:0] min_ones = 0;
    reg [3:0] sec_tens = 0;
    reg [3:0] sec_ones = 0;
    
    always @(posedge one_second_clock or posedge resetSW) begin
        if (resetSW) 
        begin
            sec_ones <= 4'd0;
            sec_tens <= 4'd0;
            min_ones <= 4'd0;
            min_tens <= 4'd0;
        end 
        else 
        begin
            if (sec_tens == 4'd5 && sec_ones == 4'd9) 
            begin
                sec_ones <= 4'd0;
                sec_tens <= 4'd0;
                if (min_tens == 4'd5 && min_ones == 4'd9) 
                begin
                    min_ones <= 4'd0;
                    min_tens <= 4'd0;
                end 
                else if (min_ones == 4'd9) 
                begin
                    min_ones <= 4'd0;
                    min_tens <= min_tens + 1;
                end 
                else 
                begin 
                    min_ones <= min_ones + 1;
                end
            end 
            else if (sec_ones == 4'd9) 
            begin 
                sec_ones <= 4'd0;
                sec_tens <= sec_tens + 1;
            end 
            else 
            begin 
                sec_ones <= sec_ones + 1;
            end
        end
    end
    always @(*)
    begin
        case(display_select)
            2'b00: digit_display = sec_ones;
            2'b01: digit_display = sec_tens;
            2'b10: digit_display = min_ones;
            2'b11: digit_display = min_tens;
            default: digit_display = 4'h0; 
        endcase
    end
endmodule 

//2 bit counter
module display_selector_counter(resetSW, POV_clock,Q);
    input resetSW;
    input POV_clock;
    output reg [1:0] Q;
    
    always @(posedge POV_clock or posedge resetSW)
    begin
        if (resetSW)
            Q <= 2'b0;
        else
            Q <= Q + 1;
    end
endmodule


//seven segment display
module seven_seg_decoder(digit_display, segments);
    input [3:0] digit_display;
    output reg [6:0] segments;
    always @(*)
    begin
        case(digit_display)
            4'h0: segments = 7'b1000000; // 0
            4'h1: segments = 7'b1111001; // 1
            4'h2: segments = 7'b0100100; // 2
            4'h3: segments = 7'b0110000; // 3
            4'h4: segments = 7'b0011001; // 4
            4'h5: segments = 7'b0010010; // 5
            4'h6: segments = 7'b0000010; // 6
            4'h7: segments = 7'b1111000; // 7
            4'h8: segments = 7'b0000000; // 8
            4'h9: segments = 7'b0010000; // 9
            default: segments = 7'b1111111; // Off
        endcase
    end
endmodule