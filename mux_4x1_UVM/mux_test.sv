class mux_test extends mux_base_test;
		`uvm_component_utils(mux_test)
  
  mux_seq seq;
  
  function new(string name = "mux_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

 
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = mux_seq::type_id::create("seq");
  endfunction : build_phase
  

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);
    seq.start(env.agent.sqr);
    phase.drop_objection(this);
    //phase.phase_done.set_drain_time(this, 50);

  endtask
      
   endclass 


