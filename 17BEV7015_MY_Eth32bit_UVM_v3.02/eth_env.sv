

`include "eth_agent.sv"
`include "eth_scoreboard.sv"

class eth_model_env extends uvm_env;
   `uvm_component_utils(eth_model_env)

  // agent and scoreboard instance
  eth_agent      eth_agnt;
  eth_scoreboard eth_scb;
  
 
  

  // constructor

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new


  // build_phase - crate the components

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    eth_agnt = eth_agent::type_id::create("eth_agnt", this);
    eth_scb  = eth_scoreboard::type_id::create("eth_scb", this);
  endfunction : build_phase
  

  // connect_phase - connecting monitor and scoreboard port

  function void connect_phase(uvm_phase phase);
    eth_agnt.monitor.item_collected_port.connect(eth_scb.item_collected_export);
  endfunction : connect_phase

endclass : eth_model_env