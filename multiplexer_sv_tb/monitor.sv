class monitor;
  virtual intf vif;
  transaction trans;
  mailbox mon2scb;
  
  function new(mailbox scb, virtual intf vif);
    this.mon2scb = scb;
    this.vif = vif;
  endfunction
  
  task run;
      trans = new();
      wait(vif.out);
      trans.a = vif.a;
      trans.b = vif.b;
      trans.sel = vif.sel;
      trans.out = vif.out;
      mon2scb.put(trans);
      trans.display("[ Monitor ]   ");
  endtask
  
endclass: monitor