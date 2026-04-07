`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 02:23:24 PM
// Design Name: 
// Module Name: asyn_fifo_tb
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


module asyn_fifo_tb();

parameter DSIZE = 8;
parameter ASIZE = 4;

reg wclk;
reg wrstn;
reg wr_en;
reg [DSIZE-1:0]wr_data;
reg rclk;
reg rrstn;
reg rd_en;
wire [DSIZE-1:0]rd_data;
wire full;
wire empty;  

integer i;

 asyn_fifo DUT(
           wclk,
           wrstn,
           wr_en,
           wr_data,
           rclk,
           rrstn,
           rd_en,
           rd_data,
           full,
           empty
          );
   
   	always                           //Generating write clock
      begin
	  wclk = 0;
	  forever begin
	   #5 wclk <= ~wclk;       
	   end
	  end   
	  
	  always                           //Generating read clock
      begin
	 rclk = 0;
	  forever begin    
	   #5 rclk <= ~rclk;   
	   end
	  end   
    
    initial begin                         //initialization
     wrstn = 0;
     wr_en = 0;
     wr_data = 0;
     rrstn = 0;
     rd_en = 0;
    end
     
     
     initial begin                      //Testing write domain
      #55;
       wrstn = 1;
       rrstn = 1;
      #20;
       wr_en = 1;
      
      for(i=1;i<=8;i=i+1)begin
        wr_data = $random;
        #10;
       end    
       
       wr_en = 0;
       
      end
      
     initial begin                          //Testing read domain
      #300;
       rrstn = 1;
      #200;
       rd_en = 1;
      #50;
       rd_en = 0;
       #10;
     //  rrstn = 0;
       
      end 
   
endmodule
