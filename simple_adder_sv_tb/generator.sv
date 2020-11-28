class generator;
  rand transaction trans;
  
  
  mailbox gen2driv;
  
  
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
  endfunction
  
  task run;
      trans=new();
    begin
      if( !trans.randomize() ) 
        $fatal("Gen::trans randomization failed");
      trans.display("[ Generator ] ");
      gen2driv.put(trans);
    end
  endtask
  
endclass:generator
      
      
    
  