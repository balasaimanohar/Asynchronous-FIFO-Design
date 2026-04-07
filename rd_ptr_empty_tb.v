`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 12:15:57 PM
// Design Name: 
// Module Name: rd_ptr_empty_tb
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


module rd_ptr_empty_tb();
parameter WIDTH = 4;
reg rd_clk;
reg rd_rstn;
reg rd_en;
reg empty;
wire [WIDTH - 1:0]rdptr;

    rd_ptr_empty DUT(rd_clk,
                     rd_rstn,
                     rd_en,
                     empty,
                     rdptr
                     );
                     
     always                           //Generating read clock
      begin
	   rd_clk = 0;
	    forever  
	     #5 rd_clk <= ~rd_clk;   
	  end   
	  
	 initial begin                    //Initial conditions
	  rd_rstn = 0;
	  rd_en = 0;
      empty = 0;
	 end  
	 
	 initial begin
	  #50;
	   rd_rstn = 1;
	   #30;
	   rd_en = 1;
//	   #40;
//	   empty = 1;
	   #160;
	    rd_en = 0; 
	  end


    
endmodule
