

module counter_property(input clk,rst_n,ld_en,updwn,en, input [7:0]datain,output [7:0]dataout);

  
  property counter_reset;
    @(clk) if(!rst_n) dataout==8'b0;
  endproperty
    
  property counter_load;
    @(posedge clk) if(rst_n & ld_en) (dataout == datain);
  endproperty
  
  property counter_DOWN_count;
    @(posedge clk) if(rst_n &!ld_en & en)
      if(updwn)##1 (dataout-1'b1)==$past(dataout);
    //else ##1 (dataout+8'h01)==$past(dataout);
  endproperty
  
  property counter_UP_count;
    @(posedge clk) if(rst_n & !ld_en & en)
      if(!updwn)##1 (dataout-1'b1)==$past(dataout);
    //else ##1 (dataout+8'h01)==$past(dataout);
  endproperty
  
  initial
  begin
    #20; 
    counter_reset_check:assert property(counter_reset)
      $display($stime,,,"\t COUNTER RESET CHECK PASS WTIH rst_n=%b dataout=%0d",rst_n,dataout);
   	else
      $display($stime,,,"\t COUNTER RESET CHECK FAIL WITH rst_n=%b dataout=%0d",rst_n,dataout);
        
    #10;      
    counter_load_check:assert property(counter_load)
      $display($stime,,,"\t COUNTER PRELOAD CHECK PASS WTIH rst_n=%b dataout=%0d",rst_n,$past(dataout));
    else
      $display($stime,,,"\t COUNTER PRELOAD CHECK FAIL WITH rst_n=%b dataout=%0d",rst_n,$past(dataout));
          
    #60;
    counter_count_check:assert property(counter_DOWN_count)
      $display($stime,,,"\t COUNTER COUNT CHECK PASS::DOWN COUNT USING $past \n");
 	else
      $display($stime,,,"\t COUNTER COUNT CHECK FAIL::DOWN COUNT USING $past \n");
  
   #90;
    counter_count_check2:assert property(counter_UP_count)
      $display($stime,,,"\t COUNTER COUNT CHECK PASS::UP COUNT USING $past \n");
 	else
      $display($stime,,,"\t COUNTER COUNT CHECK FAIL::UP COUNT USING $past \n");   
    
    end
      
endmodule
              
