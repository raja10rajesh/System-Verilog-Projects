class generator;
  rand transaction trans;
  int  repeat_count;
  
  mailbox gen2driv;
  event ended;
  
  
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
    this.ended = ended;
  endfunction
  
  task run;
    begin  
      trans=new();
      trans.constraint_mode(1);
      if( !trans.randomize()) 
        $error("Gen::trans randomization failed");
      //assert(trans.randomize());
      trans.display("[ Generator ] ");
      gen2driv.put(trans);
    end
  endtask
  
endclass:generator
      
      
    
  