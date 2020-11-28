class scoreboard;
  mailbox mon2scb;
  transaction trans;
  
  function new(mailbox mon);
    this.mon2scb =mon;
  endfunction
  
  task run;
    mon2scb.get(trans);
    trans.display("[ Scoreboard ]");
    if(trans.sel == 1'b1)
    begin
      if(trans.a == trans.out)
      begin
        $display("*******Result is as Expected*******");
      end else
      begin
        $display("Wrong Result.\n\tExpeced: %0d Actual: %0d",trans.a,trans.out);
      end
    end else if(trans.sel == 1'b0)
    begin
      if(trans.b == trans.out)
      begin
        $display("*******Result is as Expected******");
      end else
      begin
        $display("Wrong Result.\n\tExpeced: %0d Actual: %0d",trans.a,trans.out);
      end
    end 
      
  endtask
  
endclass:scoreboard