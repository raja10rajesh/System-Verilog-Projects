//`include "transaction.sv"
class driver;  
  //used to count the number of transactions
  int no_transactions;
  
  //creating virtual interface handle
  virtual intf vif;
  
  //creating mailbox handle
  mailbox gen2driv;
  
  //constructor
  function new(virtual intf vif,mailbox gen2driv);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from  environment 
    this.gen2driv = gen2driv;
  endfunction
  
  //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(vif.reset);
    $display("[ DRIVER ] ----- Reset Started -----");
    vif.dataIn_A <= 0;
    vif.dataIn_B <= 0;
    wait(!vif.reset);
    $display("[ DRIVER ] ----- Reset Ended   -----");
  endtask
  
  //drivers the transaction items to interface signals
  task main;
    forever begin
      eth_trans trans;
      gen2driv.get(trans);
      @(posedge vif.clk)
      vif.dataIn_A     <= trans.dataIn_A;
      vif.dataIn_B     <= trans.dataIn_B;
      @(posedge vif.clk);
      trans.dataOut_A   = vif.dataOut_A;
      trans.dataOut_B   = vif.dataOut_B;
      @(posedge vif.clk);
      trans.display("[ Driver ]");
      no_transactions++;
    end
  endtask
  
endclass : driver