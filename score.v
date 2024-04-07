`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/29 20:19:07
// Design Name: 
// Module Name: score
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


module score(
    input clk,
    input rst_n,
    input getpoint,
    input [1:0]p,
    output reg[5:0]point

    );
    reg prepoint;
    wire addscore=getpoint &&(!prepoint);
    always@(posedge clk  or negedge rst_n)
    begin
        if(!rst_n)begin prepoint<=0;end
        else prepoint<=getpoint;
    end
    always @(posedge clk  or negedge rst_n)
    begin 
        if(!rst_n)
        point<=0;
        else if(addscore)point<=point+p;
        else point<=point;
    end 
endmodule
