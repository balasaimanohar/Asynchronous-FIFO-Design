
module rd_ptr_empty#(parameter ASIZE = 4)
                    (input rd_clk,
                     input rd_rstn,
                     input rd_en,
                     input [ASIZE:0]sync_wr_ptr,
                     output reg empty,
                     output reg [ASIZE:0]rdptr,
                     output [ASIZE - 1:0]rdaddr
                     );
                     
 reg [ASIZE:0]rbin;
 wire [ASIZE:0]rbin_nxt,rgray_nxt;
 wire rempty;
 
  always@(posedge rd_clk or negedge rd_rstn)
   begin
    if(!rd_rstn)
     {rbin,rdptr} <= 0;
    else
     {rbin,rdptr} <= {rbin_nxt,rgray_nxt};
    end
    
    assign rbin_nxt = rbin + (rd_en & !empty);
    assign rgray_nxt = (rbin_nxt >> 1) ^ rbin_nxt;
    
    assign rdaddr = rbin[ASIZE - 1 :0];
    
    assign rempty = (rgray_nxt == sync_wr_ptr); 
    
      always@(posedge rd_clk or negedge rd_rstn)
        begin
         if(!rd_rstn)
          empty <= 1;
          else 
          empty <= rempty;
         end 
                              
endmodule                     