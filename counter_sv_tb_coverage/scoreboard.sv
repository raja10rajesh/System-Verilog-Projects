class scoreboard;
  mailbox mon2scb;
  
  transaction temp;
  
  function new(mailbox mon);
    this.mon2scb =mon;
  endfunction
  
  task run;
  begin
    transaction trans;
     mon2scb.get(trans);
      trans.display("[ Scoreboard ]");
      if(trans.ld_en)
        if(trans.dataout == trans.datain)
          $display("Loading working ");
        else
          $display("Loading Faied");
      if(trans.en)
        if(trans.updwn)
          if(trans.dataout == trans.dataout)
            $display("UP working");
          else
            $display("UP Failed");
        else
          if(trans.dataout == trans.dataout)
            $display("Down working");
          else
            $display("Down Failed");
   end
  endtask
      
    

endclass:scoreboard