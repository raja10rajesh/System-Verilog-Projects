class eth_agent extends uvm_agent;
  //declaring agent components
  eth_driver    driver;
  eth_sequencer sequencer;
  eth_monitor   monitor;
 
  // UVM automation macros for general components
  `uvm_component_utils(eth_agent)
 
  // constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
  // build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    if(get_is_active() == UVM_ACTIVE) begin
      driver = eth_driver::type_id::create("driver", this);
      sequencer = eth_sequencer::type_id::create("sequencer", this);
    end
 
    monitor = eth_monitor::type_id::create("monitor", this);
  endfunction : build_phase
 
  // connect_phase
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction : connect_phase
 
endclass : eth_agent