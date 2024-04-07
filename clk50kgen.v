`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/03 15:29:37
// Design Name: 
// Module Name: clk50kgen
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


module clk50kgen(
    input clk,
    output clk_50k

    );
    localparam  cc=8'd100;
    reg [7:0]count=8'd0;
    reg clk_m=0;
    always @(posedge clk)
    begin 
        count<=count+1;
        if(count==cc-1)
        begin
            clk_m<=~clk_m;
            count<=8'd0;
        end
    end
    assign clk_50k=clk_m;
endmodule
