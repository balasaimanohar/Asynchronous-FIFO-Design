`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2026 01:46:21 PM
// Design Name: 
// Module Name: FIFO_mem
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


module FIFO_mem#(parameter ASIZE=3,
                 parameter DSIZE=8)
                  (input wr_clk,
				   input wr_rstn,
				   input wr_en,
				   input rd_clk,
				   input rd_rstn,
				   input rd_en,
				   input [ASIZE - 1 : 0]wr_addr,
				   input [ASIZE - 1 : 0]rd_addr,
				   input [DSIZE - 1 : 0]wr_data,
				   output reg [DSIZE - 1 : 0]rd_data,
				   input full,
				   input empty
                );
    integer i;    
           
    localparam DEPTH = 1 << ASIZE;  
           
    reg [DSIZE-1:0] mem [0:DEPTH-1];
    
  //WRITE BLOCK
  
    always@(posedge wr_clk)
     begin
      if(!wr_rstn)
       begin
        for(i=0;i<=DEPTH-1;i=i+1)
         mem[i] = 0;
       end
      else
       begin
        if (wr_en && !full) 
         mem[wr_addr] <= wr_data;
       end
     end
     
  //READ BLOCK  
  // assign rd_data = (!rd_rstn) ? 0 : mem[rd_addr];
    
     
    always@(posedge rd_clk)
     begin
      if(!rd_rstn)
       begin
        rd_data <= 0;
       end
      else
       begin
        if (rd_en && !empty) 
         rd_data <= mem[rd_addr];
       end
     end
     
endmodule
