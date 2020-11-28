`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
class environment;
  int no_test;
  integer count =1 ;
  driver 		driv;
  generator 	gen;
  monitor 		mon;
  scoreboard 	scb;
  
  mailbox gen2driv;
  mailbox mon2scb;
  
  virtual intf vif;
  
  function new(virtual intf vif);
    this.vif = vif;
  endfunction
  
  task build;  
    gen2driv = new();
    mon2scb = new();
    
    gen 	= 	new(gen2driv);
    driv 	= 	new(gen2driv,vif);
    mon  	= 	new(mon2scb,vif);
    scb		= 	new(mon2scb);
  endtask
  

  
  task run;
    repeat(no_test)
    begin
      $display("test no: %0d",count);
      count++;
      $display("-------------------------");
      gen.run;
      #10 driv.run;
	  #50  mon.run;
      scb.run;
      $display("-------------------------");
    end
  endtask
  
endclass:environment