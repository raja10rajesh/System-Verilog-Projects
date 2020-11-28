
`define DRIV_IF vif.DRIVER.driver_cb

class eth_driver extends uvm_driver #(eth_seq_item);


  virtual eth_if vif;
  `uvm_component_utils(eth_driver)
    

  // Constructor

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new


  // build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual eth_if)::get(this, "", "vif", vif))
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase


  // run phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask : run_phase
  

  // drive - transaction level to signal level
  // drives the value's from seq_item to interface signals

  virtual task drive();
    `DRIV_IF.Ain <= 0;
    `DRIV_IF.Bin <= 0;
    @(posedge vif.DRIVER.clk);
    `DRIV_IF.Ain <= req.Ain;
    `DRIV_IF.Bin <= req.Bin;
    @(posedge vif.DRIVER.clk);
    `DRIV_IF.inDataA <= req.inDataA;
    `DRIV_IF.inDataB <= req.inDataB;
    @(posedge vif.DRIVER.clk);
    @(posedge vif.DRIVER.clk);
    req.outDataA = `DRIV_IF.outDataA;
    req.outDataB = `DRIV_IF.outDataB;
    req.Aout = `DRIV_IF.Aout;
    req.Bout = `DRIV_IF.Bout;
  endtask : drive
  
endclass : eth_driver