class mux_env extends uvm_env;
	`uvm_component_utils(mux_env)

	mux_agent       agent;
    mux_scoreboard  scb;
	mux_coverage    cov;
  
	function new(string name="",uvm_component parent);
		super.new(name,parent);
	endfunction

  
	function void build_phase(uvm_phase phase);
     super.build_phase(phase);
	  agent = mux_agent::type_id::create("agent",this);
      scb   = mux_scoreboard::type_id::create("scb",this);
	  cov   = mux_coverage::type_id::create("cov",this);
	endfunction
  
  

	function void connect_phase(uvm_phase phase);
	  agent.mon.item_collected_port.connect(cov.analysis_export);
      agent.mon.item_collected_port.connect(scb.item_collected_export);
    
	endfunction
  
  
endclass : mux_env
