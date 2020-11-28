

`include "eth_seq_item.sv"
`include "eth_sequencer.sv"
`include "eth_sequence.sv"
`include "eth_driver.sv"
`include "eth_monitor.sv"

class eth_agent extends uvm_agent;


  // component instances

  eth_driver    driver;
  eth_sequencer sequencer;
  eth_monitor   monitor;

  `uvm_component_utils(eth_agent)
  

  // constructor

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new


  // build_phase

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor = eth_monitor::type_id::create("monitor", this);

    //creating driver and sequencer only for ACTIVE agent
    if(get_is_active() == UVM_ACTIVE) begin
      driver    = eth_driver::type_id::create("driver", this);
      sequencer = eth_sequencer::type_id::create("sequencer", this);
    end
  endfunction : build_phase

  // connect_phase - connecting the driver and sequencer port
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction : connect_phase

endclass : eth_agent