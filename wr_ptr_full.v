`timescale 1ns / 1ps



module wr_ptr_full#(parameter ASIZE=3)
                   (input wr_clk,
                    input wr_rstn,
                    input wr_en,
                    input [ASIZE:0]sync_rd_ptr,
                    output reg full,
                    output [ASIZE - 1:0]wr_addr,
                    output reg [ASIZE :0]wrptr
                   );
                   
     reg [ASIZE:0]wbin;
     wire [ASIZE:0]wbin_nxt,wgray_nxt;
     wire wfull;
     
     always@(posedge wr_clk or negedge wr_rstn)
      begin
       if(!wr_rstn)
        {wbin,wrptr} <= 0;
       else 
         {wbin,wrptr} <= {wbin_nxt,wgray_nxt};
       end
       
       assign wbin_nxt = wbin + (wr_en & !full);
       assign wgray_nxt = (wbin_nxt >> 1) ^ wbin_nxt;
       
       assign wr_addr = wbin[ASIZE - 1 :0];
       
       assign wfull = (wgray_nxt == {~sync_rd_ptr[ASIZE:ASIZE-1],sync_rd_ptr[ASIZE-2:0]});
       
       always@(posedge wr_clk or negedge wr_rstn)
        begin
         if(!wr_rstn)
          full <= 0;
          else 
           full <= wfull;
        end 
       
       
       
endmodule
