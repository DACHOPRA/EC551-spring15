`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:54:32 04/21/2015 
// Design Name: 
// Module Name:    sync 
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

module sync(clk_lcd, reset, Hsync,Vsync, flagh, flagv, hcount_reg);

input  reset, clk_lcd; 
output reg  Vsync, flagh, flagv,Hsync; 
output reg [9:0] hcount_reg; 
reg [8:0] Vcount_reg; 
reg H_SYNC, V_SYNC, FLAG_H, FLAG_V; 

//Horizontal SYNC
always @(posedge clk_lcd or posedge reset)
begin
if(reset)
hcount_reg<=0;
else
begin
if (hcount_reg<525) 
hcount_reg<=hcount_reg+1'b1;
else 
hcount_reg<=0;
end
end
always@(posedge clk_lcd)
begin
if (hcount_reg<45) 
H_SYNC<=0;
else
H_SYNC<=1;
end 

always@(posedge clk_lcd)
begin
if((hcount_reg>45)&(hcount_reg<525)) 
FLAG_H<=1;
else
FLAG_H<=0;
end
//Vertical SYNC
always@(posedge clk_lcd or posedge reset)
begin
if(reset)
Vcount_reg<=0;
else
begin
if(hcount_reg==525) 
if (Vcount_reg<288) 
Vcount_reg<=Vcount_reg+1'b1; 
else 
Vcount_reg<=0;
end
end
always@(posedge clk_lcd)
begin
if (Vcount_reg<16)
V_SYNC<=0;
else
V_SYNC<=1;
end
always@(posedge clk_lcd)
begin
if((Vcount_reg>16)&(Vcount_reg<288)) 
FLAG_V<=1;
else
FLAG_V<=0;
end

always@(posedge clk_lcd) 
begin
Hsync<=H_SYNC;
Vsync<=V_SYNC; //blank or color
flagh<=FLAG_H; //display area
flagv<=FLAG_V;
end




endmodule
