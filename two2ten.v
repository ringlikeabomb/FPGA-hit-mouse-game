`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/03 14:06:16
// Design Name: 
// Module Name: two2ten
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


module two2ten(
    input	[5:0]	bin_in,
	output	[6:0]	bcd_out

    );

	
    reg [3:0] ones;
    reg [2:0] tens;
    integer i;
    
    always @(*) begin   
        ones=4'd0;
        tens=4'd0;     
        for(i = 5; i >= 0; i = i - 1) begin
            if (ones >= 4'd5) 		ones = ones + 4'd3;
            if (tens >= 4'd5) 		tens = tens + 4'd3;
            tens	 = {tens[1:0],ones[3]};
            ones	 = {ones[2:0],bin_in[i]};
        end
    end	
    assign bcd_out = {tens, ones};

endmodule
