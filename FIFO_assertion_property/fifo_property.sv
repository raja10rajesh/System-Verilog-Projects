`define inside_ptr tester_fifo.DUT

module fifo_property (input clk,reset_n,write_en,read_en,input [31:0]data_in,output empty,full,output [31:0]data_out);
  parameter FIFO_D=8;
  parameter FIFO_W=32;
  

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
 
  
  initial
  begin
    #10
    check_resetp:assert property(check_reset)
      $display($time, "\t Reset Check PASS::check_reset\n");
    else
      $display($time, "\t Reset Check FAIL::check_reset\n"); 
      
    #20
    check_fifoemptyp:assert property(fifoempty)
      $display($time, "\t FIFO is EMPTY::check_reset\n");
    else
      $display($time, "\t NOT EMPTY::check_reset\n");
       
    #20
    check_fifofullp:assert property(fifofull)        
      $display($time, "\t FIFO is FULL \n");
    else    
      $display($time, "\t FIFO is Partially FULL \n");
      
    #20
    check_fifofullp2:assert property(fifofull)        
      $display($time, "\t FIFO is FULL \n");
    else    
      $display($time, "\t FIFO is Partially FULL \n");  
    
	#20
    check_fifofullp3:assert property(fifofull)        
      $display($time, "\t FIFO is FULL \n");
    else    
      $display($time, "\t FIFO is Partially FULL \n"); 
      
    #20
    check_fifofullp4:assert property(fifofull)        
      $display($time, "\t FIFO is Full \n");
    else    
      $display($time, "\t FIFO is Partially FULL \n");   
      
    #20  
    check_fifofullp5:assert property(fifofull)        
      $display($time, "\t FIFO is Full \n");
    else    
      $display($time, "\t FIFO is Partially FULL \n");   
      
    #20
    check_fifofullwrite:assert property(fifo_full_write)
      $display($time, "\t Read and Write Both possible\n");
    else
      $display($time, "\t Write ImPossible \n");          
          
  end
      
  
endmodule