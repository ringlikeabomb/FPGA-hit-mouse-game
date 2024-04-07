`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/29 18:57:26
// Design Name: 
// Module Name: random
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


module random(
    input clk,
    input  [15:0] seed,
    input rst_n,
    output reg [15:0] data,
    output [2:0]data3
    );
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
           data<=seed;
        else
            data<={data[14],data[15]^data[13],data[12]^data[15],data[11],data[10]^data[15],data[9:0],data[15]};
    end
    assign data3={data[7],data[3],data[1]};
endmodule
