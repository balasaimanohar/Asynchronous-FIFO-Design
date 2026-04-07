module sync_r2w_tb;
parameter WIDTH = 4;
 reg wr_clk;
 reg rd_clk;
 reg wr_rstn;
 reg [WIDTH-1:0]rd_ptr;
 wire [WIDTH-1:0]sync_rdptr; 
 integer k;
 
  sync_r2w DUT(wr_clk,
               wr_rstn,
               rd_ptr,
               sync_rdptr   
               ); 
   
   	always                           //Generating write clock
      begin
	  wr_clk = 0;
	  forever begin
	   #5 wr_clk <= ~wr_clk;       
	   end
	  end   
	  
	 always                           //Generating read clock
      begin
	 rd_clk = 0;
	  forever begin    
	   #2 rd_clk <= ~rd_clk;   
	   end
	  end   
	
	  
	initial begin                    //Initial conditions
	  wr_rstn = 0;
	  rd_ptr = 0;
	  k=0;
	 end  
	 
	 initial begin
	  #55;
	  wr_rstn = 1;
	  #20;
	   @(posedge rd_clk)
	    for(k=0;k<=7;k=k+1)begin
	      rd_ptr <= (k>>1) ^ k;
	      #4;
	     end
	   end
	 
	 
 endmodule
                                    