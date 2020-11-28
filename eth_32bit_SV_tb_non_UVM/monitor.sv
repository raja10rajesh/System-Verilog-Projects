class monitor;
  
  //creating virtual interface handle
  virtual intf vif;
  
  //creating mailbox handle
  mailbox mon2scb;
  
  //constructor
  function new(virtual intf vif,mailbox mon2scb);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
  endfunction
  
  //Samples the interface signal and send the sample packet to scoreboard
  task main;
    forever begin
      eth_trans trans;
      trans = new();
      @(posedge vif.clk);
      trans.dataIn_A   = vif.dataIn_A;
      trans.dataIn_B   = vif.dataIn_B;
      @(posedge vif.clk);
      trans.dataOut_A   = vif.dataOut_A;
      trans.dataOut_B   = vif.dataOut_B;
      @(posedge vif.clk);
      mon2scb.put(trans);
      trans.display("[ Monitor ]");
    end
  endtask
  
endclass