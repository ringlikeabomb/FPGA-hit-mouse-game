`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/29 16:32:51
// Design Name: 
// Module Name: top_module
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


module top_module(
    input clk,
    input rst_n,
    input startn,
    input  [3:0]  r_pin,
    output [3:0]  c_pin,
    output       tmds_clk_p,    
    output       tmds_clk_n,
    output [2:0] tmds_data_p,  
    output [2:0] tmds_data_n
    //output       tmds_oen      

    );
    wire start=!startn;
    wire  [7:0]   key;
    wire          pixel_clk;
    wire          pixel_clk_5x;
    wire          clk_locked;

    wire  [10:0]  pixel_xpos_w;
    wire  [10:0]  pixel_ypos_w;
    wire  [23:0]  pixel_data_w;

    wire          video_hs;
    wire          video_vs;
    wire          video_de;
    wire  [23:0]  video_rgb;

    wire newstart;
    wire en;
    wire ini;
    wire [7:0]led;
    wire [2:0]round;
    wire [5:0]score;
    wire clk_10m;
    wire clk_50k;
    keycontrol x_key(
    .clk(clk),
    .rst(rst_n),
    .c_pin(c_pin),
    .r_pin(r_pin),
    .key_out(key)
    );
    clk_wiz_0  clk_wiz_0(
    .clk_in1        (clk),
    .clk_out1       (pixel_clk),        
    .clk_out2       (pixel_clk_5x),  
    .clk_out3       (clk_10m),     
    
    .reset          (~rst_n), 
    .locked         (clk_locked)
    );
    clk50kgen clkgen(
        .clk(clk_10m),
        .clk_50k(clk_50k)
    );
    buttonstable startstable(
        .clk(clk_50k),      //2ms
        .button(start),
        .rst_n(rst_n),
        .stable_button(newstart)

    );
    startcontrol x_start(
        .clk(clk),
        .rst_n(rst_n),
        .start(newstart),
        .en(en),
        .round(round),
        .ini(ini)
    );
    led xiaohualed(
        .rst_n(rst_n),
        .en(en),
        .clk(clk_50k), //0.05Mhz
        .hit(key),
        .led(led),
        .ini(ini),
        .round(round),
        .point(score)
    );
    
    video_driver u_video_driver(
    .pixel_clk      (pixel_clk),
    .sys_rst_n      (rst_n),

    .video_hs       (video_hs),
    .video_vs       (video_vs),
    .video_de       (video_de),
    .video_rgb      (video_rgb),

    .pixel_xpos     (pixel_xpos_w),
    .pixel_ypos     (pixel_ypos_w),
    .pixel_data     (pixel_data_w)
    );
    video_display  u_video_display(
    .pixel_clk      (pixel_clk),
    .ini            (ini),
    .led            (led),
    .point          (score),
    .round          (round), 
    .en             (en),

    .pixel_xpos     (pixel_xpos_w),
    .pixel_ypos     (pixel_ypos_w),
    .pixel_data     (pixel_data_w)
    );
    dvi_transmitter_top u_rgb2dvi_0(
    .pclk           (pixel_clk),
    .pclk_x5        (pixel_clk_5x),
    .reset_n        (rst_n & clk_locked),
                
    .video_din      (video_rgb),
    .video_hsync    (video_hs), 
    .video_vsync    (video_vs),
    .video_de       (video_de),
                
    .tmds_clk_p     (tmds_clk_p),
    .tmds_clk_n     (tmds_clk_n),
    .tmds_data_p    (tmds_data_p),
    .tmds_data_n    (tmds_data_n)
    //.tmds_oen       (tmds_oen)
    );
endmodule
