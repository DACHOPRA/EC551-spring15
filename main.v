`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:53 04/21/2015 
// Design Name: 
// Module Name:    main 
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
module main(input Clk,rst,output [7:0]data_RED,output [7:0]data_BLUE,output  [7:0]data_GREEN,
output DISP,TFT_en,DE_clk,clk_out,x,backlight
    );

wire clk_lcd,flagv,flagh,de_en,disp_en,led_en,rgb_en;
wire [9:0]hcount_reg;
wire Vsync,Hsync; 

clkdivled c2(Clk,led_en,backlight); //Enable backlight 43 khz

clkdiv9 c1(Clk, rst, clk_lcd);//9Mhz pixel clk

DE d2(de_en,clk_lcd,DE_clk);//DE clk for hsync and vsync

sync s1(clk_lcd, rst,Hsync,Vsync, flagh, flagv, hcount_reg);

display d1(disp_en,rgb_en,clk_lcd, flagv, flagh, Hsync,Vsync, DISP, data_RED, data_BLUE, data_GREEN, hcount_reg,x);

controlclk c3(Clk,clk_out); //83 ms to enable different states

controlunit cu1(clk_out,rst,TFT_en,de_en,disp_en,led_en,rgb_en);

endmodule
