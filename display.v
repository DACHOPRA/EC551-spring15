`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:20 04/21/2015 
// Design Name: 
// Module Name:    display 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module display(disp_en,rgb_en,clk_lcd, flagv, flagh, Hsync,Vsync, DISP, data_RED, data_BLUE, data_GREEN, hcount_reg,x);
				
input clk_lcd,flagh, flagv, Hsync,Vsync,disp_en,rgb_en; 
input  [9:0] hcount_reg;
output reg [7:0] data_RED, data_BLUE;
output reg [7:0] data_GREEN;
output reg DISP,x;
reg [7:0] RED, BLUE;
reg [7:0] GREEN; 
wire Data_out;


initial
begin
data_RED<=8'hff; 
data_BLUE<=8'h00; 
data_GREEN<=8'hff; 
DISP<=0;
x=0;
end




// AND between flagh y flagv
assign Data_out=(flagh&flagv);

//signal DISP
always@(posedge clk_lcd)
begin
if (disp_en && Vsync && Hsync)
DISP<=1;
else 
DISP<=0; 
end

//3 colors (RGB) 
always@(posedge clk_lcd)
begin 
if (Data_out) begin 
if (hcount_reg<523) begin 
RED<=8'hff; 
BLUE<=8'h00; 
GREEN<=8'hff; 
end 
else begin 
RED<=8'h0; 
BLUE<=8'hff; 
GREEN<=8'hff;
end 
end
end
//Output sync  
always@(posedge clk_lcd) 
begin 
if(rgb_en)begin
data_RED<=RED; 
data_BLUE<=BLUE; 
data_GREEN<=GREEN; 
x=~x;
end 
end
endmodule
