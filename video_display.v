`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/02 15:54:03
// Design Name: 
// Module Name: video_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module video_display(
    input                pixel_clk,
    input                ini,
    input        [7:0]   led,
    input        [2:0]   round,
    input        [5:0]   point,
    input                en,
    
    input        [10:0]  pixel_xpos,  
    input        [10:0]  pixel_ypos,  
    output  reg  [23:0]  pixel_data   
    );
    parameter  H_DISP = 11'd1280;
    parameter  V_DISP = 11'd720;
    parameter  h_start = 8'd180;
    parameter  v_start = 6'd60;
    parameter  h_hua=8'd200;
    parameter  v_hua=8'd200;
    parameter  h_round=8'd200;
    parameter  v_round=6'd50;
    parameter  h_score=8'd200;
    parameter  v_score=6'd50;
    parameter  h_number=8'd32;
    parameter  v_number=6'd50;        
    localparam WHITE  = 24'b11111111_11111111_11111111;
    localparam RED    = 24'b11111111_00001100_00000000;
    reg [15:0]hua_addr;
    reg [10:0]zero_addr;
    reg [10:0]one_addr;
    reg [10:0]two_addr;
    reg [10:0]three_addr;
    reg [10:0]four_addr;
    reg [10:0]five_addr;
    reg [10:0]six_addr;
    reg [10:0]seven_addr;
    reg [10:0]eight_addr;
    reg [10:0]nine_addr;
    reg [13:0]round_addr;
    reg [13:0]score_addr;
    //reg [16:0]stop_addr;
    reg [13:0]start_addr;
    wire [23:0]hua_data;
    wire [23:0]one_data;
    wire [23:0]two_data;
    wire [23:0]three_data;
    wire [23:0]four_data;
    wire [23:0]five_data;
    wire [23:0]six_data;
    wire [23:0]seven_data;
    wire [23:0]eight_data;
    wire [23:0]nine_data;
    wire [23:0]zero_data;
    wire [23:0]score_data;
    wire [23:0]start_data;
    wire [23:0]round_data;
    //wire [23:0]stop_data;
    reg  [1:0]xpos_m;
    wire  [6:0]bcdscore;
    reg  ypos_m;
    blk_mem_gen_0 hua (
    .clka(pixel_clk),    // input wire clka
    .addra(hua_addr),  // input wire [16 : 0] addra
    .douta(hua_data)  // output wire [23 : 0] douta
    );
    always@(posedge pixel_clk)begin
        case(led)
        8'b1000_0000:begin  xpos_m<=2'd0;ypos_m<=0; end
        8'b0100_0000:begin  xpos_m<=2'd1;ypos_m<=0; end
        8'b0010_0000:begin  xpos_m<=2'd2;ypos_m<=0; end
        8'b0001_0000:begin  xpos_m<=2'd3;ypos_m<=0; end
        8'b0000_1000:begin  xpos_m<=2'd0;ypos_m<=1; end
        8'b0000_0100:begin  xpos_m<=2'd1;ypos_m<=1; end
        8'b0000_0010:begin  xpos_m<=2'd2;ypos_m<=1; end
        8'b0000_0001:begin  xpos_m<=2'd3;ypos_m<=1; end
        default :begin  xpos_m<=2'd0;ypos_m<=0; end
        endcase
    
    end
    always @(posedge pixel_clk ) begin
    if (ini)begin
        if((pixel_xpos>=(H_DISP/2-h_start/2))&&(pixel_xpos<(H_DISP/2+h_start/2))
        &&(pixel_ypos>=(V_DISP/2-v_start/2))&&(pixel_ypos<(V_DISP/2+v_start/2)))begin
            start_addr<=(pixel_xpos-(H_DISP/2-h_start/2))+(pixel_ypos-(V_DISP/2-v_start/2))*h_start;
            pixel_data<=start_data;

        end
        else   pixel_data <= WHITE;
    end
    else if(round==0 || ((!ini)&&(!en)))begin 
        if((pixel_xpos>=(H_DISP/2-h_hua/2))&&(pixel_xpos<(H_DISP/2+h_hua/2))
        &&(pixel_ypos>=(V_DISP/2-v_hua))&&(pixel_ypos<(V_DISP/2)))begin
            hua_addr<=(pixel_xpos-(H_DISP/2-h_hua/2))+(pixel_ypos-(V_DISP/2-v_hua))*h_hua;
            pixel_data<=hua_data;
        end
        else if((pixel_xpos>=(H_DISP/2-h_hua))&&(pixel_xpos<(H_DISP/2-h_hua+h_score))
        &&(pixel_ypos>=(V_DISP/2))&&(pixel_ypos<(V_DISP/2+v_score)))begin
            score_addr<=(pixel_xpos-(H_DISP/2-h_hua))+(pixel_ypos-(V_DISP/2))*h_score;
            pixel_data<=score_data;
        end
        else if((pixel_xpos>=(H_DISP/2-h_hua+h_score+h_number))&&(pixel_xpos<(H_DISP/2-h_hua+h_score+2*h_number))
        &&(pixel_ypos>=(V_DISP/2))&&(pixel_ypos<(V_DISP/2+v_number)))begin
            case(bcdscore[6:4])
            3'd1: 
            begin 
                one_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=one_data;
            end
            3'd2: 
            begin 
                two_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=two_data;
            end
            3'd3: 
            begin 
                three_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=three_data;
            end
            3'd4: 
            begin 
                four_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=four_data;
            end
            endcase
        
        end
        else if((pixel_xpos>=(H_DISP/2-h_hua+h_score+2*h_number))&&(pixel_xpos<(H_DISP/2-h_hua+h_score+3*h_number))
        &&(pixel_ypos>=(V_DISP/2))&&(pixel_ypos<(V_DISP/2+v_number)))begin
        case(bcdscore[3:0])
            4'd1: 
            begin 
                one_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+2*h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=one_data;
            end
            4'd2: 
            begin 
                two_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+2*h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=two_data;
            end
            4'd3: 
            begin 
                three_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+2*h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=three_data;
            end
            4'd4: 
            begin 
                four_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+2*h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=four_data;
            end
            4'd5: 
            begin 
                five_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+2*h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=five_data;
            end
            4'd6: 
            begin 
                six_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+2*h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=six_data;
            end
            4'd7: 
            begin 
                seven_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+2*h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=seven_data;
            end
            4'd8: 
            begin 
                eight_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+2*h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=eight_data;
            end
            4'd9: 
            begin 
                nine_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+2*h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=nine_data;
            end
            4'd0: 
            begin 
                zero_addr<=(pixel_xpos-(H_DISP/2-h_hua+h_score+2*h_number))+(pixel_ypos-(V_DISP/2))*h_number;
                pixel_data<=zero_data;
            end
            endcase
        
        end
        else pixel_data<=WHITE;
           
        
    end
    else begin
        if(((pixel_xpos>=(H_DISP/4-2))&&(pixel_xpos<((H_DISP/4)*1+1))&&(pixel_ypos>=(0))&&(pixel_ypos<((H_DISP/4)*2+1)))
        ||((pixel_xpos>=((H_DISP/4)*2-2))&&(pixel_xpos<((H_DISP/4)*2+1))&&(pixel_ypos>=(0))&&(pixel_ypos<((H_DISP/4)*2+1)))
        ||((pixel_xpos>=((H_DISP/4)*3-2))&&(pixel_xpos<((H_DISP/4)*3+1))&&(pixel_ypos>=(0))&&(pixel_ypos<((H_DISP/4)*2+1)))
        ||(((pixel_ypos>=((H_DISP/4)*1-2))&&(pixel_ypos<((H_DISP/4)*1+1))))||(((pixel_ypos>=((H_DISP/4)*2-2))&&(pixel_ypos<((H_DISP/4)*2+1)))))
        pixel_data<=RED;
        else if((|led)&&(pixel_xpos>=((H_DISP/8)*(2*xpos_m+1)-h_hua/2))&&(pixel_xpos<((H_DISP/8)*(2*xpos_m+1)+h_hua/2))
        &&(pixel_ypos>=((H_DISP/8)*(2*ypos_m+1)-v_hua/2))&&(pixel_ypos<((H_DISP/8)*(2*ypos_m+1)+v_hua/2)))
        begin
            hua_addr<=(pixel_xpos-((H_DISP/8)*(2*xpos_m+1)-h_hua/2))+(pixel_ypos-((H_DISP/8)*(2*ypos_m+1)-v_hua/2))*h_hua;
            pixel_data<=hua_data;
        end
        else if((pixel_xpos>=(H_DISP/8-h_round/2))&&(pixel_xpos<(H_DISP/8+h_round/2))
        &&(pixel_ypos>=(V_DISP/2+H_DISP/4-v_round/2))&&(pixel_ypos<(V_DISP/2+H_DISP/4+v_round/2)))
        begin
            round_addr<=(pixel_xpos-(H_DISP/8-h_round/2))+(pixel_ypos-(V_DISP/2+H_DISP/4-v_round/2))*h_round;
            pixel_data<=round_data;
        end
        else if((pixel_xpos>=((H_DISP/2)+H_DISP/8-h_score/2))&&(pixel_xpos<((H_DISP/2)+H_DISP/8+h_score/2))
        &&(pixel_ypos>=(V_DISP/2+(H_DISP/4)-v_score/2))&&(pixel_ypos<(V_DISP/2+(H_DISP/4)+v_score/2)))
        begin
            score_addr<=(pixel_xpos-((H_DISP/2)+H_DISP/8-h_score/2))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_score/2))*h_score;
            pixel_data<=score_data;
        end
        else if((pixel_xpos>=((H_DISP/4)))&&(pixel_xpos<((H_DISP/4)+h_number))
        &&(pixel_ypos>=(V_DISP/2+(H_DISP/4)-v_number/2))&&(pixel_ypos<(V_DISP/2+(H_DISP/4)+v_number/2)))
        begin
            
            case(round)
            2'd1: 
            begin 
                one_addr<=(pixel_xpos-((H_DISP/4)))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=one_data;
            end
            2'd2: 
            begin 
                two_addr<=(pixel_xpos-((H_DISP/4)))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=two_data;
            end
            2'd3: 
            begin 
                three_addr<=(pixel_xpos-((H_DISP/4)))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=three_data;
            end
            endcase
        end
        else if((pixel_xpos>=((H_DISP/4)*3))&&(pixel_xpos<((H_DISP/4)*3+h_number))
        &&(pixel_ypos>=(V_DISP/2+(H_DISP/4)-v_number/2))&&(pixel_ypos<(V_DISP/2+(H_DISP/4)+v_number/2)))
        begin
            
            case(bcdscore[6:4])
            3'd1: 
            begin 
                one_addr<=(pixel_xpos-((H_DISP/4)*3))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=one_data;
            end
            3'd2: 
            begin 
                two_addr<=(pixel_xpos-((H_DISP/4)*3))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=two_data;
            end
            3'd3: 
            begin 
                three_addr<=(pixel_xpos-((H_DISP/4)*3))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=three_data;
            end
            3'd4: 
            begin 
                four_addr<=(pixel_xpos-((H_DISP/4)*3))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=four_data;
            end
            endcase
        end
        else if((pixel_xpos>=((H_DISP/4)*3+h_number))&&(pixel_xpos<((H_DISP/4)*3+2*h_number))
        &&(pixel_ypos>=(V_DISP/2+(H_DISP/4)-v_number/2))&&(pixel_ypos<(V_DISP/2+(H_DISP/4)+v_number/2)))
        begin
            
            case(bcdscore[3:0])
            4'd1: 
            begin 
                one_addr<=(pixel_xpos-((H_DISP/4)*3+h_number))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=one_data;
            end
            4'd2: 
            begin 
                two_addr<=(pixel_xpos-((H_DISP/4)*3+h_number))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=two_data;
            end
            4'd3: 
            begin 
                three_addr<=(pixel_xpos-((H_DISP/4)*3+h_number))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=three_data;
            end
            4'd4: 
            begin 
                four_addr<=(pixel_xpos-((H_DISP/4)*3+h_number))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=four_data;
            end
            4'd5: 
            begin 
                five_addr<=(pixel_xpos-((H_DISP/4)*3+h_number))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=five_data;
            end
            4'd6: 
            begin 
                six_addr<=(pixel_xpos-((H_DISP/4)*3+h_number))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=six_data;
            end
            4'd7: 
            begin 
                seven_addr<=(pixel_xpos-((H_DISP/4)*3+h_number))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=seven_data;
            end
            4'd8: 
            begin 
                eight_addr<=(pixel_xpos-((H_DISP/4)*3+h_number))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=eight_data;
            end
            4'd9: 
            begin 
                nine_addr<=(pixel_xpos-((H_DISP/4)*3+h_number))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=nine_data;
            end
            4'd0: 
            begin 
                zero_addr<=(pixel_xpos-((H_DISP/4)*3+h_number))+(pixel_ypos-(V_DISP/2+(H_DISP/4)-v_number/2))*h_number;
                pixel_data<=zero_data;
            end
            endcase
        end
        else pixel_data<=WHITE;



    end
    
    end
    two2ten x_two2ten(
        .bin_in(point),
        .bcd_out(bcdscore)
    );
    blk_mem_gen_1 zero (
    .clka(pixel_clk),    // input wire clka
    .addra(zero_addr),  // input wire [10 : 0] addra
    .douta(zero_data)  // output wire [23 : 0] douta
    );
    blk_mem_gen_2 one (
    .clka(pixel_clk),    // input wire clka
    .addra(one_addr),  // input wire [10 : 0] addra
    .douta(one_data)  // output wire [23 : 0] douta
    );
    blk_mem_gen_3 two (
    .clka(pixel_clk),    // input wire clka
    .addra(two_addr),  // input wire [10 : 0] addra
    .douta(two_data)  // output wire [23 : 0] douta
    );
    blk_mem_gen_4 three (
    .clka(pixel_clk),    // input wire clka
    .addra(three_addr),  // input wire [10 : 0] addra
    .douta(three_data)  // output wire [23 : 0] douta
    );
    blk_mem_gen_5 four (
    .clka(pixel_clk),    // input wire clka
    .addra(four_addr),  // input wire [10 : 0] addra
    .douta(four_data)  // output wire [23 : 0] douta
    );
    blk_mem_gen_6 five (
    .clka(pixel_clk),    // input wire clka
    .addra(five_addr),  // input wire [10 : 0] addra
    .douta(five_data)  // output wire [23 : 0] douta
    );
    blk_mem_gen_7 six (
    .clka(pixel_clk),    // input wire clka
    .addra(six_addr),  // input wire [10 : 0] addra
    .douta(six_data)  // output wire [23 : 0] douta
    );
    blk_mem_gen_8 seven (
    .clka(pixel_clk),    // input wire clka
    .addra(seven_addr),  // input wire [10 : 0] addra
    .douta(seven_data)  // output wire [23 : 0] douta
    );
    blk_mem_gen_9 eight (
    .clka(pixel_clk),    // input wire clka
    .addra(eight_addr),  // input wire [10 : 0] addra
    .douta(eight_data)  // output wire [23 : 0] douta
    );
    blk_mem_gen_10 nine (
    .clka(pixel_clk),    // input wire clka
    .addra(nine_addr),  // input wire [10 : 0] addra
    .douta(nine_data)  // output wire [23 : 0] douta
    );
    blk_mem_gen_11 x_round (
    .clka(pixel_clk),    // input wire clka
    .addra(round_addr),  // input wire [13 : 0] addra
    .douta(round_data)  // output wire [23 : 0] douta
    );
    blk_mem_gen_12 x_score (
    .clka(pixel_clk),    // input wire clka
    .addra(score_addr),  // input wire [13 : 0] addra
    .douta(score_data)  // output wire [23 : 0] douta
    );
    blk_mem_gen_13 x_start (
    .clka(pixel_clk),    // input wire clka
    .addra(start_addr),  // input wire [16 : 0] addra
    .douta(start_data)  // output wire [23 : 0] douta
    );


endmodule
