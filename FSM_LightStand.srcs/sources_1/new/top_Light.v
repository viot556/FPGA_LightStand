`timescale 1ns / 1ps

module top_Light(
    input i_clk,
    input i_reset,
    input [2:0] i_button,
    output o_y

);
    wire w_clk_1MHz;

clockDivider Div(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_clk(w_clk_1MHz)
    );
    wire [9:0] w_divcount;
counter Count(
    .i_clk(w_clk_1MHz),
    .i_reset(i_reset),
    .o_counter(w_divcount)
    );
    
    wire [3:0] w_x;

comparator Comp(
    .i_counter(w_divcount),
    .o_Light_1(w_x[0]), 
    .o_Light_2(w_x[1]), 
    .o_Light_3(w_x[2]), 
    .o_Light_4(w_x[3])
    );

    wire [2:0] w_btn;

Button_Controller BtnCon1(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(i_button[0]),
    .o_button(w_btn[0])
    );

Button_Controller BtnCon2(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(i_button[1]),
    .o_button(w_btn[1])
    );

Button_Controller BtnCon3(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(i_button[2]),
    .o_button(w_btn[2])
    );

    wire [2:0] w_sel;

FSM_Light FSM(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(w_btn),
    .o_light(w_sel)
    );

mux Mux(
    .i_x(w_x),
    .sel(w_sel),
    .o_y(o_y)
    );




endmodule
