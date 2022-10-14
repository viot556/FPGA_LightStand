`timescale 1ns / 1ps

module comparator(
    input [9:0] i_counter,
    output o_Light_1, o_Light_2, o_Light_3, o_Light_4
    );

    assign o_Light_1 = (i_counter < 300) ? 1'b1 : 1'b0; //300일때 1bit 1인가
    assign o_Light_2 = (i_counter < 600) ? 1'b1 : 1'b0;
    assign o_Light_3 = (i_counter < 800) ? 1'b1 : 1'b0;
    assign o_Light_4 = (i_counter < 999) ? 1'b1 : 1'b0;
    
endmodule