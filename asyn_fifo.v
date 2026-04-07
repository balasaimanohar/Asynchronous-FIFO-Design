`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 11:21:44 PM
// Design Name: 
// Module Name: asyn_fifo
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


module asyn_fifo#(parameter DSIZE = 8,
                  parameter ASIZE = 3
                  )(
                  input wclk,
                  input wrstn,
                  input wr_en,
                  input [DSIZE-1:0]wr_data,
                  input rclk,
                  input rrstn,
                  input rd_en,
                  output [DSIZE-1:0]rd_data,
                  output full,
                  output empty

    );
    
    wire [ASIZE - 1:0]twr_addr;
    wire [ASIZE - 1:0]trd_addr;
    wire [ASIZE:0]tsync_rd_ptr;
    wire [ASIZE:0]tsync_wr_ptr;
    wire [ASIZE:0]twr_ptr;
    wire [ASIZE:0]trd_ptr;
    
    
    
    
    FIFO_mem #(.ASIZE(ASIZE),
               .DSIZE(DSIZE))
		  fifo_mem(.wr_clk(wclk),
				   .wr_rstn(wrstn),
				   .wr_en(wr_en),
				   .rd_clk(rclk),
				   .rd_rstn(rrstn),
				   .rd_en(rd_en),
				   .wr_addr(twr_addr),
				   .rd_addr(trd_addr),
				   .wr_data(wr_data),
				   .rd_data(rd_data),
				   .full(full),
				   .empty(empty)
				  );
				  
    wr_ptr_full#(.ASIZE(ASIZE))
        wr_ptr_full(.wr_clk(wclk),
                    .wr_rstn(wrstn),
                    .wr_en(wr_en),
                    .sync_rd_ptr(tsync_rd_ptr),
                    .full(full),
                    .wr_addr(twr_addr),
                    .wrptr(twr_ptr)
                   );
    
    sync_w2r#(.ASIZE(ASIZE))
         sync_w2r(.rd_clk(rclk),
                  .rd_rstn(rrstn),
                  .wr_ptr(twr_ptr),
                  .sync_wrptr(tsync_wr_ptr)   
                   );
    
    rd_ptr_empty#(.ASIZE(ASIZE))
        rd_ptr_empty(.rd_clk(rclk),
                     .rd_rstn(rrstn),
                     .rd_en(rd_en),
                     .sync_wr_ptr(tsync_wr_ptr),
                     .empty(empty),
                     .rdptr(trd_ptr),
                     .rdaddr(trd_addr)
                     );
    
    sync_r2w#(.ASIZE(ASIZE))
          sync_r2w(.wr_clk(wclk),
                  .wr_rstn(wrstn),
                  .rd_ptr(trd_ptr),
                  .sync_rdptr(tsync_rd_ptr)   
                   );  
    
endmodule
