`define inside_ptr tester_fifo.DUT  
  parameter FIFO_W = 32;
  parameter FIFO_D = 8;


module tester_fifo;
  reg clk,reset_n,write_en,read_en;
  reg [FIFO_W-1:0] data_in;
  wire empty,full;
  wire [FIFO_W-1:0] data_out;
  
 
  property check_reset;
    @(posedge clk)
    if(!reset_n) (full==0 && empty==1 && `inside_ptr.front_ptr == 0 && `inside_ptr.end_ptr == 0);
  endproperty
 
  
  property fifoempty;
    @(posedge clk) if(reset_n && read_en && (`inside_ptr.front_ptr-`inside_ptr.end_ptr==0))
      (empty==1 && full==0);
  endproperty
  
  
  property fifofull;
    @(posedge clk) 
    if((reset_n) && (!read_en)&& (write_en))
      ((empty==0) && (full==1));
  endproperty
  
  property fifo_full_write;
    @(posedge clk)
    if((reset_n) && (!read_en)&& (write_en))
      ((`inside_ptr.front_ptr-`inside_ptr.end_ptr!=FIFO_D) && (empty==0) && (full==0));
  endproperty
  
  
  
  fifo#(.FIFO_D(FIFO_D),.FIFO_W(FIFO_D)) DUT(.clk(clk),
                                             .reset_n(reset_n),
                                             .write_en(write_en),
                                             .read_en(read_en),
                                             .data_in(data_in),
                                             .data_out(data_out),
                                             .empty(empty),
                                             .full(full)
                                            );
  
  
  
  initial
  begin
    clk=1'b0;
    forever #5 clk=~clk;
  end
                                             
  initial 
  begin
         reset_n = 1'b0; write_en = 1'b0; read_en = 1'b0; data_in = 32'h0;
    #10; check_resetp:assert property(check_reset)
           $display($time, "\t Reset Check PASS::check_reset\n");
         else
           $display($time, "\t Reset Check FAIL::check_reset\n");	
    #10; reset_n = 1'b1; write_en = 1'b0; read_en = 1'b0; 
    #20; 			     write_en = 1'b0; read_en = 1'b1;
         check_fifoemptyp:assert property(fifoempty)
      	   $display($time, "\t FIFO is EMPTY::check_reset\n");
         else
           $display($time, "\t NOT EMPTY::check_reset\n");
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h126598AB;
         check_fifofullp:assert property(fifofull)        
      	   $display($time, "\t FIFO is FULL \n");
         else    
           $display($time, "\t FIFO is Partially FULL \n");
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h126598AB;
         check_fifofullp2:assert property(fifofull)        
      	   $display($time, "\t FIFO is FULL \n");
         else    
           $display($time, "\t FIFO is Partially FULL \n");
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h106598A0;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h166998A1;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h126592A2;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h126598A8;
         check_fifofullp3:assert property(fifofull)        
      	   $display($time, "\t FIFO is FULL \n");
         else    
           $display($time, "\t FIFO is Partially FULL \n"); 
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h156598AB;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h126F98A6;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h1C6598AB;
         check_fifofullp4:assert property(fifofull)        
      	   $display($time, "\t FIFO is FULL \n");
         else    
           $display($time, "\t FIFO is Partially FULL \n");  
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h126598A5;
         check_fifofullp5:assert property(fifofull)        
      	   $display($time, "\t FIFO is FULL \n");
         else    
           $display($time, "\t FIFO is Partially FULL \n");
    #10;                 write_en = 1'b0; read_en = 1'b1; 
    #10;                 write_en = 1'b0; read_en = 1'b1;
         check_fifofullwrite:assert property(fifo_full_write)
      	   $display($time, "\t Read and Write Both possible\n");
         else
           $display($time, "\t Write ImPossible \n"); 
    #10; reset_n = 1'b0; write_en = 1'b0; read_en = 1'b1;
    #10; check_resetp2:assert property(check_reset)
           $display($time, "\t Reset Check PASS::check_reset\n");
         else
           $display($time, "\t Reset Check FAIL::check_reset\n");
    #10; reset_n = 1'b1; write_en = 1'b1; read_en = 1'b1; 
    
    
    $finish(2);
    end
           
            
  always @ (posedge clk)
  begin
    $display("%t rst_n:%d,Write En:%d,Read En:%d,Data In:%d,DataOut:%d,Empty:%d,Full:%d",$time,reset_n,write_en,read_en,data_in,data_out,empty,full);
  end                                         
                                             

                                             
  initial
  begin
    $dumpfile("counter.vcd");
    $dumpvars(1);
  end

          
endmodule
          
          