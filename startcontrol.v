`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/02 16:27:56
// Design Name: 
// Module Name: startcontrol
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


module startcontrol(
    input clk,
    input start,
    input rst_n,
    input [2:0] round,
    output reg en,
    output reg ini

    );
    parameter s0=2'b00,
    s1=2'b01,
    s2=2'b11;
    reg [1:0]c_state=s0;
    reg [1:0]n_state;
    reg rst_n_de;
    always@(posedge clk )
    begin
        rst_n_de<=rst_n;
    end
    wire rst_none;
    assign rst_none=rst_n|(!rst_n_de);
    reg start_de;
    always@(posedge clk )
    begin
        start_de<=start;
    end
    wire start_one;
    assign start_one=start&(!start_de);
    always@(c_state)                       
    begin
        case(c_state) 
        s0:begin en<=0;ini<=1;end
        s1:begin en<=1;ini<=0;end
        s2:begin en<=0;ini<=0;end 
        endcase
    end
     always@(c_state or  start_one or  rst_none or round)             //现态和输入决定次态
    begin
        case(c_state)
        s0:
        begin
            if(rst_none==0)n_state<=s0;
            else if(start_one==1)n_state<=s1;
            else n_state<=s0;
        end
        s1:
        begin
            if(rst_none==0)n_state<=s0;
            else if(start_one==1)n_state<=s2;
            else n_state<=s1;
        end
        s2:
        begin
            if(rst_none==0)n_state<=s0;
            else if(start_one==1 || round ==3'd0)n_state<=s0;
            else n_state<=s2;
        end
        endcase
    end
    always@(posedge clk )
    begin
        c_state<=n_state;           
    end

endmodule
