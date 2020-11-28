
class mux_base_test extends uvm_test;
  `uvm_component_utils(mux_base_test)
  
  mux_env env;

  function new(string name = "mux_base_test",uvm_component parent =null);
    super.new(name,parent);
  endfunction : new

  // build_phase

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = mux_env::type_id::create("env", this);
  endfunction : build_phase
  

  
  
  virtual function void end_of_elaboration();
    //print's the topology
    //print();
    uvm_top.print_topology();
  endfunction


  
  
 function void report_phase(uvm_phase phase);
   uvm_report_server svr;
   super.report_phase(phase);
   svr = uvm_report_server::get_server();
   if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0) begin
     `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
     `uvm_info(get_type_name(), "----            TEST FAIL          ----", UVM_NONE)
     `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end
    else begin
     `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
     `uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
     `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end
  endfunction 

endclass : mux_base_test
