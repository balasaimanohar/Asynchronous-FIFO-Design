`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2025 04:33:21 PM
// Design Name: 
// Module Name: sync_r2w
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


module sync_r2w#(parameter ASIZE= 4)
                 (input wr_clk,
                  input wr_rstn,
                  input [ASIZE:0]rd_ptr,
                  output reg [ASIZE:0]sync_rdptr   
                   );
    reg [ASIZE:0] sync_rdptr1;
      
      always@(posedge wr_clk or wr_rstn)begin                //Here we are using 2 stage flip flop to avoid metastability 
         if(!wr_rstn)
            {sync_rdptr,sync_rdptr1} <= 0;
          else
            {sync_rdptr,sync_rdptr1} <= {sync_rdptr1,rd_ptr};     
          end
          
          
endmodule
