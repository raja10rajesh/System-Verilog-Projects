class scoreboard;
  mailbox mon2scb;
  transaction trans;
  
  function new(mailbox mon);
    this.mon2scb =mon;
  endfunction
  
  task run;
    mon2scb.get(trans);
    trans.display("[ Scoreboard ]");
    if(trans.en)
      if(trans.out == (1<<trans.in))
        $display("MATCHED::WORKING FINE\n\n");
      else
        $fatal("MISMATCH:: expected:%0d-- Received :%0d",(1<<trans.in),trans.out);
    else
      if(trans.out == 16'b0)
        $display("Not enable, Output Zero\n\n");
      else
        $fatal("MISMATCH:: expected:16'bz -- Received :%0d",(1<<trans.in));
  endtask
  
endclass:scoreboard