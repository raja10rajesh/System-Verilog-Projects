class driver;
  transaction trans;
  virtual intf vif;
  
  mailbox gen2driv;
  
  function new(mailbox gen2driv, virtual intf vif);
    this.gen2driv = gen2driv;
    this.vif = vif;
  endfunction
  
  
  task run;
    begin
      gen2driv.get(trans);
      @(posedge vif.DRIVER.clk);
      vif.ld_en <= trans.ld_en;
      vif.updwn <= trans.updwn;
      vif.en    <= trans.en;
      vif.datain<= trans.datain;
      wait(vif.DRIVER.clk);
      trans.dataout = vif.dataout;
      trans.display("[ Driver ]    ");
    end
  endtask
  
endclass: driver
