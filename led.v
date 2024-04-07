`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/30 11:43:13
// Design Name: 
// Module Name: led
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


module led(
    input rst_n,
    input en,
    input ini,
    input clk,
    input  [7:0]hit,               
    output reg[7:0]led,
    output reg [2:0]round,
    output wire [5:0]point

    );
    reg [15:0]seed=127;
    //reg [15:0]data;
    reg [15:0]count1;
    reg [15:0]count2;
    reg [3:0]mousenumber;
    reg [3:0]hitnumber;
    reg [15:0]time1;
    reg [15:0]time2;
    //reg [2:0]data3;
    wire getpoint;
    assign getpoint=|(hit & led);
    wire [2:0] w_data3;
    wire [15:0] w_data;
    //wire [5:0] w_point;
    //assign w_data=data;
    //assign w_data3=data3;
    //assign w_point=point;
    reg [1:0]p;
    score com_score(
        .clk(clk),
        .rst_n(rst_n && (!ini)),
        .getpoint(getpoint),
        .point(point),
        .p(p)
    );
    reg rst_n_de;
    always@(posedge clk )
    begin
        rst_n_de<=!ini;
    end
    wire rst_ran;
    assign rst_ran=(!ini)|(!rst_n_de);
    random ss_random(
        .clk(clk),
        .seed(seed),
        .rst_n(rst_ran && (rst_n)),
        .data(w_data),
        .data3(w_data3)
    );
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
            begin
                seed<=seed+4'd10;
                led<=8'd0;
                count1<=16'd0;
                mousenumber<=0;
                hitnumber<=0;
                round<=1;
                count2<=17'd0;
                p<=1;
                time2<=17'd50000;
                time1<=w_data;
            end
        else if(ini)
            begin
                seed<=seed+4'd10;
                led<=8'd0;
                count1<=16'd0;
                mousenumber<=0;
                hitnumber<=0;
                round<=1;
                count2<=17'd0;
                p<=1;
                time2<=17'd50000;
                time1<=w_data;
        
            end
        else if(en&&round!=0&&!ini)
        begin
           
            if(!(|led))
            begin 
                if(count1==time1)
                begin
                    led<=1<<w_data3;
                    count2<=0;
                    time1<=w_data;
                end
                else count1<=count1+1;
            end
            else 
                begin
                if(getpoint || count2==time2) 
                begin 
                    led<=8'd0;
                    if(getpoint)hitnumber<=hitnumber+1;
                    mousenumber<=mousenumber+1;
                    count1<=0;
                end
                else count2<=count2+1;
            end
            if(mousenumber==8 && hitnumber <= 4)
            begin
                round<=0;
            end
            if(mousenumber==8 && hitnumber >4)
            begin
                mousenumber<=0;
                hitnumber<=0;
                if(round==3)round<=0;
                else round<=round+1;
            end
            if(round==2)
            begin 
                time2<=17'd30000;
                p<=2;
            end
            if(round==3)
            begin 
                time2<=17'd20000;
                p<=3;
            end
        end
    end



endmodule
