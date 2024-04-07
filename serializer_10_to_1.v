`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/03 16:27:17
// Design Name: 
// Module Name: serializer_10_to_1
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


module serializer_10_to_1(
    input           reset,              
    input           paralell_clk,       
    input           serial_clk_5x,      
    input   [9:0]   paralell_data,      

    output 			serial_data_out     

    );
    wire		cascade1;    
    wire		cascade2;
    OSERDESE2 #(
        .DATA_RATE_OQ   ("DDR"),      
        .DATA_RATE_TQ   ("SDR"),       
        .DATA_WIDTH     (10),           
        .SERDES_MODE    ("MASTER"),    
        .TBYTE_CTL      ("FALSE"),     
        .TBYTE_SRC      ("FALSE"),    
        .TRISTATE_WIDTH (1)             // 3-state converter width (1,4)
    )
    OSERDESE2_Master (
        .CLK        (serial_clk_5x),    
        .CLKDIV     (paralell_clk),     
        .RST        (reset),            // 1-bit input: Reset
        .OCE        (1'b1),             // 1-bit input: Output data clock enable
        
        .OQ         (serial_data_out),  
        
        .D1         (paralell_data[0]), 
        .D2         (paralell_data[1]),
        .D3         (paralell_data[2]),
        .D4         (paralell_data[3]),
        .D5         (paralell_data[4]),
        .D6         (paralell_data[5]),
        .D7         (paralell_data[6]),
        .D8         (paralell_data[7]),
    
        .SHIFTIN1   (cascade1),         
        .SHIFTIN2   (cascade2),         
        .SHIFTOUT1  (),                
        .SHIFTOUT2  (),                 
            
        .OFB        (),                 
        .T1         (1'b0),             
        .T2         (1'b0),
        .T3         (1'b0),
        .T4         (1'b0),
        .TBYTEIN    (1'b0),             
        .TCE        (1'b0),             
        .TBYTEOUT   (),                 
        .TFB        (),                 
        .TQ         ()                  
    );
    
    OSERDESE2 #(
        .DATA_RATE_OQ   ("DDR"),       
        .DATA_RATE_TQ   ("SDR"),       
        .DATA_WIDTH     (10),           
        .SERDES_MODE    ("SLAVE"),     
        .TBYTE_CTL      ("FALSE"),     
        .TBYTE_SRC      ("FALSE"),     
        .TRISTATE_WIDTH (1)             
    )
    OSERDESE2_Slave (
        .CLK        (serial_clk_5x),    
        .CLKDIV     (paralell_clk),     
        .RST        (reset),            
        .OCE        (1'b1),             
        
        .OQ         (),                
        
        .D1         (1'b0),             
        .D2         (1'b0),
        .D3         (paralell_data[8]),
        .D4         (paralell_data[9]),
        .D5         (1'b0),
        .D6         (1'b0),
        .D7         (1'b0),
        .D8         (1'b0),
    
        .SHIFTIN1   (),                 
        .SHIFTIN2   (),                 
        .SHIFTOUT1  (cascade1),         
        .SHIFTOUT2  (cascade2),         
            
        .OFB        (),                
        .T1         (1'b0),             
        .T2         (1'b0),
        .T3         (1'b0),
        .T4         (1'b0),
        .TBYTEIN    (1'b0),             
        .TCE        (1'b0),             
        .TBYTEOUT   (),                 
        .TFB        (),                 
        .TQ         ()                  
    ); 
endmodule
