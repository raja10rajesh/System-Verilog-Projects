  module test_counter;
    logic clk,rst_n,ld_en,updwn,en;
    logic[7:0] datain;
    wire [7:0] dataout;
    
   property counter_reset;
     @(clk) if(!rst_n) dataout==8'b0;
   endproperty
  
   property counter_DOWN_count;
     @(posedge clk) if(!rst_n &ld_en & en)
       if(!updwn)##1 (dataout-8'h01)==$past(dataout); 
  endproperty
    
   property counter_UP_count;
     @(posedge clk) if(!rst_n &ld_en & en)
       if(updwn)##1 (dataout+8'h01)==$past(dataout);
  endproperty
  
          	
  counter8b u1(.clk(clk),
               .rst_n(rst_n),
               .ld_en(ld_en),
               .updwn(updwn),
               .en(en),
               .datain(datain),
               .dataout(dataout)
              );
      
          

    initial
    begin
      clk=1'b0;
      forever #5 clk=~clk;
	end
    
    initial 
    begin
	       rst_n=1'b1; ld_en=1'b0;            en=1'b0;
               
	  #20; rst_n=1'b0; ld_en=1'b0;            en=1'b0;
      counter_reset_check:assert property(counter_reset)
        $display($stime,,,"\t COUNTER RESET CHECK PASS WTIH rst_n=%b dataout=%0d",rst_n,dataout);
      else
        $display($stime,,,"\t COUNTER RESET CHECK FAIL WITH rst_n=%b dataout=%0d",rst_n,dataout);
      
      #20; rst_n=1'b1; ld_en=1'b1;datain=8'h64; 
      #20; if(rst_n==1'b1 && ld_en==1'b1)
           assert(dataout==datain)
             $display($stime,,,"\t COUNTER PRELOAD CHECK PASS WTIH datain=%b dataout=%0d",datain,dataout);
           else
             $display($stime,,,"\t COUNTER PRELOAD CHECK FAIL WITH datain=%b dataout=%0d",datain,dataout);
              
                       ld_en=1'b0;            en=1'b1; updwn=1'b0;
      #10; 
      counter_count_check:assert property(counter_DOWN_count)
        $display($stime,,,"\t COUNTER COUNT CHECK PASS::DOWN COUNT USING USING $past \n");
 	  else
        $display($stime,,,"\t COUNTER COUNT CHECK FAIL::DOWN COUNT USING USING $past \n");
      #50;											   updwn=1'b1; 
      #10;
      counter_count_check2:assert property(counter_UP_count)
        $display($stime,,,"\t COUNTER COUNT CHECK PASS::UP COUNT USING USING $past \n");
 	  else
        $display($stime,,,"\t COUNTER COUNT CHECK FAIL::UP COUNT USING USING $past \n");
       
      #50;            ld_en=1'b1;			  en=1'b0;
         
              
      #20;
      $finish(2);                
    end
 		
    always @(posedge clk)
    begin
      $display($stime,,,"rst_n=%b clk=%b en=%b ld_en=%b updwn=%b DIN=%0d Dout=%0d",rst_n,clk,en,ld_en,updwn,datain,dataout);
    end
         
        
    initial
    begin
      $dumpfile("counter.vcd");
      $dumpvars(1);
    end

          
endmodule
          
          