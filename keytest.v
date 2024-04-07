`timescale 1ns / 1ps

module keycontrol(
    input               clk,
    input               rst,
    output reg[3:0]     c_pin,
    input[3:0]          r_pin,
    output reg[7:0]     key_out

  );
  reg[2:0]          state;
  reg[15:0] 		div_cnt;
  reg				cnt_full;
  localparam        CHECK_R1=3'b000;
  localparam        CHECK_R2=3'b001;
  localparam        CHECK_R3=3'b011;
  localparam        CHECK_R4=3'b010;
    //filter out the key jitter
  reg  [3 :0]       r_pin_0buf;
  reg               r_pin_0key;
  reg  [3 :0]       r_pin_1buf;
  reg               r_pin_1key;
  reg  [3 :0]       r_pin_2buf;
  reg               r_pin_2key;
  reg  [3 :0]       r_pin_3buf;
  reg               r_pin_3key;
  wire [3 :0]       r_pin_key;
  always@(posedge clk or negedge rst)begin
    if(!rst)begin
      div_cnt <= 16'd0;
      cnt_full <= 1'b0;
    end
    else
      if(div_cnt==16'd49999)begin
      //if(div_cnt==16'd499)begin
        div_cnt <= 16'd0;
        cnt_full <= 1'b1;
      end
      else begin
        div_cnt <= div_cnt + 1'b1;
        cnt_full <= 1'b0;
      end
  end
  //r_pin_0buf
always@(posedge clk or negedge rst)
begin
    if(!rst)
        r_pin_0buf <= 4'b0000;
    else if ( cnt_full == 1'b1 )
        r_pin_0buf <= 4'b0000;
    else if (( div_cnt == 16'd20000 ) || ( div_cnt == 16'd22000 ) || ( div_cnt == 16'd24000 ) || ( div_cnt == 16'd26000 ))
        r_pin_0buf <= {r_pin_0buf[2:0],r_pin[0]};
    else
        ;
end
always@(posedge clk)
begin
    if ( r_pin_0buf == 4'b1111 )
        r_pin_0key <= 1'b1;
    else if ( r_pin_0buf == 4'b0000 )
        r_pin_0key <= 1'b0;
    else
        ;
end
//r_pin_1buf
always@(posedge clk or negedge rst)
begin
    if(!rst)
        r_pin_1buf <= 4'b0000;
    else if ( cnt_full == 1'b1 )
        r_pin_1buf <= 4'b0000;
    else if (( div_cnt == 16'd20000 ) || ( div_cnt == 16'd22000 ) || ( div_cnt == 16'd24000 ) || ( div_cnt == 16'd26000 ))
        r_pin_1buf <= {r_pin_1buf[2:0],r_pin[1]};
    else
        ;
end
always@(posedge clk)
begin
    if ( r_pin_1buf == 4'b1111 )
        r_pin_1key <= 1'b1;
    else if ( r_pin_1buf == 4'b0000 )
        r_pin_1key <= 1'b0;
    else
        ;
end
//r_pin_2buf
always@(posedge clk or negedge rst)
begin
    if(!rst)
        r_pin_2buf <= 4'b0000;
    else if ( cnt_full == 1'b1 )
        r_pin_2buf <= 4'b0000;
    else if (( div_cnt == 16'd20000 ) || ( div_cnt == 16'd22000 ) || ( div_cnt == 16'd24000 ) || ( div_cnt == 16'd26000 ))
        r_pin_2buf <= {r_pin_2buf[2:0],r_pin[2]};
    else
        ;
end
always@(posedge clk)
begin
    if ( r_pin_2buf == 4'b1111 )
        r_pin_2key <= 1'b1;
    else if ( r_pin_2buf == 4'b0000 )
        r_pin_2key <= 1'b0;
    else
        ;
end
//r_pin_3buf
always@(posedge clk or negedge rst)
begin
    if(!rst)
        r_pin_3buf <= 4'b0000;
    else if ( cnt_full == 1'b1 )
        r_pin_3buf <= 4'b0000;
    else if (( div_cnt == 16'd20000 ) || ( div_cnt == 16'd22000 ) || ( div_cnt == 16'd24000 ) || ( div_cnt == 16'd26000 ))
        r_pin_3buf <= {r_pin_3buf[2:0],r_pin[3]};
    else
        ;
end
always@(posedge clk)
begin
    if ( r_pin_3buf == 4'b1111 )
        r_pin_3key <= 1'b1;
    else if ( r_pin_3buf == 4'b0000 )
        r_pin_3key <= 1'b0;
    else
        ;
end

assign r_pin_key = {r_pin_3key,r_pin_2key,r_pin_1key,r_pin_0key};
  always@(posedge clk)begin
    if(!rst)
      state <= CHECK_R1;
    else
      case(state)
        CHECK_R1:
          if(cnt_full)
            state <= CHECK_R2;
          else
            state <= CHECK_R1;
        CHECK_R2:
          if(cnt_full)
            state <= CHECK_R3;
          else
            state <= CHECK_R2;
        CHECK_R3:
          if(cnt_full)
            state <= CHECK_R4;
          else
            state <= CHECK_R3;
        CHECK_R4:
          if(cnt_full)
            state <= CHECK_R1;
          else
            state <= CHECK_R4;
        default:
          state <= state;
      endcase
  end
  always@(posedge clk or negedge rst)begin
    if(!rst)
      c_pin <= 4'b0000;
    else
      case(state)
        CHECK_R1:begin
          c_pin <= 4'b1000;
          case(r_pin_key)
            4'b1000:key_out <= 8'b0001_0000; //a 
            4'b0100:key_out <= 8'b0010_0000;//3
            4'b0010:key_out <= 8'b0100_0000;//2
            4'b0001:key_out <= 8'b1000_0000;//1
            default:;
          endcase
        end
        CHECK_R2:begin
          c_pin <= 4'b0100;
          key_out <= 8'd0;
        end
        CHECK_R3:begin
          c_pin <= 4'b0010;
          key_out <= 8'd0;
        end
        CHECK_R4:begin
          c_pin <= 4'b0001;
          case(r_pin_key)
            4'b1000:key_out <= 8'b0000_0001;  
            4'b0100:key_out <= 8'b0000_0010;  
            4'b0010:key_out <= 8'b0000_0100;
            4'b0001:key_out <= 8'b0000_1000;  
            default:;
          endcase
        end
        default:begin
          c_pin <= 4'b0000;
          key_out <= 8'd0;
        end
      endcase
  end
endmodule