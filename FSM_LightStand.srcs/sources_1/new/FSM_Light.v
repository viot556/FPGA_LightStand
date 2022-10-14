`timescale 1ns / 1ps

module FSM_Light(
    input i_clk,
    input i_reset,
    input [2:0] i_button,
    output [2:0] o_light
    );

    parameter   S_Light_0 = 3'b000,
                S_Light_1 = 3'b001,
                S_Light_2 = 3'b010,
                S_Light_3 = 3'b011,
                S_Light_4 = 3'b100;

    //상태를 저장할 수 있는 값이 있어야함
    reg [1:0] curState, nextState;
    reg [2:0] r_light; //밖으로 나가는 값
    assign o_light = r_light;

    //상태 변경 적용(비동기식 적용), 상태 변경 ,reset 처리(clk에 맞춰서 동작)
    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) curState <= S_Light_0;
        else         curState <= nextState;
    end


    //이벤트 처리 부분

    always @(curState or i_button) begin
        case (curState)
            S_Light_0 : begin
                if(i_button[1]) nextState <= S_Light_1;
                else            nextState <= S_Light_0;
            end
            S_Light_1 : begin
                if(i_button[1])        nextState <= S_Light_2;
                else if(i_button[2]) nextState <= S_Light_0;
                else if(i_button[0])  nextState <= S_Light_0;
                else                   nextState <= S_Light_1;
            end
            S_Light_2 : begin
                if(i_button[1])        nextState <= S_Light_3;
                else if(i_button[2]) nextState <= S_Light_1;
                else if(i_button[0])  nextState <= S_Light_0;
                else                   nextState <= S_Light_2;
            end
            S_Light_3 : begin
                if(i_button[1])        nextState <= S_Light_4;
                else if(i_button[2]) nextState <= S_Light_2;
                else if(i_button[0])  nextState <= S_Light_0;
                else                   nextState <= S_Light_3;
            end
            S_Light_4 : begin
                if(i_button[2]) nextState <= S_Light_3 ;
                else if(i_button[0])  nextState <= S_Light_0;
                else                   nextState <= S_Light_4;
            end
        endcase
    end

    //상태에 따른 동작 부분 - 실제동작 (현재상태를 감시하여 상태를 변경할 것임)
    always @(curState) begin
        r_light <= 3'bxxx; //floating 상태 
        case (curState)
            S_Light_0 : r_light <= 3'b000;
            S_Light_1 : r_light <= 3'b001;
            S_Light_2 : r_light <= 3'b010;
            S_Light_3 : r_light <= 3'b011;
            S_Light_4 : r_light <= 3'b100;
            // default : nextState <= S_LED_11;
        endcase
    end
endmodule
