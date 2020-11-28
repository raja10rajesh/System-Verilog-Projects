class mux_monitor extends uvm_monitor;
  `uvm_component_utils(mux_monitor)
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual mux_intf vif;
  uvm_analysis_port#(mux_tx) item_collected_port;
  mux_tx txx;
  
  
//build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual mux_intf)::get(this,"","vif",vif))) begin
		`uvm_fatal("monitor","unable to get interface")
	end
	item_collected_port = new("item_collected_port",this);
	txx = mux_tx::type_id::create("txx",this);	
  endfunction : build_phase

//runphase
  task run_phase(uvm_phase phase);
  forever
    begin
      @(vif.select); 
	txx.a = vif.x;
	txx.b = vif.y;
	txx.select = vif.select;
    txx.out    =  vif.mux_out;
      //$display("PKT:MONITOR");
	//txx.print();
	item_collected_port.write(txx);
  end
  endtask : run_phase
  
endclass : mux_monitor
