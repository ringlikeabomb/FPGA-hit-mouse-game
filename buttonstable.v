`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/29 21:30:20
// Design Name: 
// Module Name: buttonstable
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


module buttonstable(
    input clk,
    input button,
    input rst_n,
    output reg stable_button

    );
    parameter JIT =5'b01010 ;
    reg [4:0]count;
    reg pre_button;
    always@(posedge clk or negedge rst_n)begin      
        if(!rst_n)stable_button<=button;
        else
        begin
            pre_button<=button;
            if(pre_button!=button || count==JIT)count<=0;//按键仍在抖动或已经稳定，停止计数
            else count<=count+1;
            if(count==JIT )stable_button<=button; //稳定后进行赋值
        end
    end
endmodule
