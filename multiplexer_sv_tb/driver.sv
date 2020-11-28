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
    vif.a = trans.a;
    vif.b = trans.b;
    vif.sel = trans.sel;
    wait(vif.out);
    trans.out = vif.out;
    trans.display("[ Driver ]    ");
  endtask
  
endclass: driver
