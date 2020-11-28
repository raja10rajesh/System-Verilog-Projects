class scoreboard;
  mailbox mon2scb;
  transaction trans;
  
  function new(mailbox mon);
    this.mon2scb =mon;
  endfunction
  
  task run;
    mon2scb.get(trans);
    trans.display("[ Scoreboard ]");
    if((trans.a+trans.b) == trans.c)
      $display("*******Result is as Expected*****");
    else
      $display("Wrong Result.\n\tExpeced: %0d Actual: %0d",(trans.a+trans.b),trans.c);
  endtask
  
endclass:scoreboard