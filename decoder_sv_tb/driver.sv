class driver;
  
  transaction trans;
  virtual intf vif;
  
  mailbox gen2driv;
  
  function new(mailbox gen2driv, virtual intf vif);
    this.gen2driv = gen2driv;
    this.vif = vif;
  endfunction
  
  task run;
    trans = new();
    gen2driv.get(trans);
    vif.en = trans.en;
    vif.in = trans.in;
    //wait(vif.out);
    trans.out = vif.out;
    trans.display("[ Driver ]    ");
  endtask
  
endclass: driver
