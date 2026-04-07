`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2025 10:41:13 AM
// Design Name: 
// Module Name: sync_w2r
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


module sync_w2r#(parameter ASIZE = 4)
                 (input rd_clk,
                  input rd_rstn,
                  input [ASIZE:0]wr_ptr,
                  output reg [ASIZE:0]sync_wrptr   
                   );
    reg [ASIZE:0] sync_wrptr1;
      
      always@(posedge rd_clk or rd_rstn)begin
         if(!rd_rstn)
            {sync_wrptr,sync_wrptr1} <= 0;
          else
            {sync_wrptr,sync_wrptr1} <= {sync_wrptr1,wr_ptr};     
          end

   
endmodule
