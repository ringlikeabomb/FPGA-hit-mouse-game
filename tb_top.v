`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/03 15:43:13
// Design Name: 
// Module Name: tb_top
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


module tb_top(

    );
    reg clk;
    reg rst_n;
    reg start;
    reg [7:0]  key;
    wire       tmds_clk_p;    
    wire       tmds_clk_n;
    wire [2:0] tmds_data_p;  
    wire [2:0] tmds_data_n;
    wire       tmds_oen;  
    top_module top(
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .key(key),
        .tmds_clk_n(tmds_clk_n),
        .tmds_clk_p(tmds_clk_p),
        .tmds_data_n(tmds_data_n),
        .tmds_data_p(tmds_data_p),
        .tmds_oen(tmds_oen)
    );
    initial begin
        clk=0;
        rst_n=1;
        start=0;
        key=8'd0;
        #50000
        rst_n=0;
        #50000
        rst_n=1;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #1000000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #10000000
        key=8'b11111111;
        #10000000
        key=8'd0;
        #10000000
        key=8'b11111111;
        #10000000
        key=8'd0;
        #10000000
        key=8'b11111111;
        #10000000
        key=8'd0;
        #10000000
        key=8'b11111111;
        #10000000
        key=8'd0;
        #10000000
        key=8'b11111111;
        #10000000
        key=8'd0;
        #10000000
        key=8'b11111111;
        #10000000
        key=8'd0;
        #10000000
        key=8'b11111111;
        #10000000
        key=8'd0;
        #10000000
        key=8'b11111111;
        #10000000
        key=8'd0;
        #10000000
        key=8'b11111111;
        #10000000
        key=8'd0;
        #10000000
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #1000000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;
        #100000
        start=1;
        #100000
        start=0;

        



    end
    always #5 clk<=~clk;
endmodule
