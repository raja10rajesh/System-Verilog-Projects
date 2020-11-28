
class eth_monitor extends uvm_monitor;
  `uvm_component_utils(eth_monitor)

  virtual eth_if vif;


  // analysis port, to send the transaction to scoreboard

  uvm_analysis_port #(eth_seq_item) item_collected_port;
  

  // The following property holds the transaction information currently
  // begin captured (by the collect_address_phase and data_phase methods).
  eth_seq_item trans_collected;





  function new (string name, uvm_component parent);
    super.new(name, parent);
    trans_collected = new();
    item_collected_port = new("item_collected_port", this);
  endfunction : new


  // build_phase - getting the interface handle

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual eth_if)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase
  


  // i.e, sample the values on interface signal and assigns to transaction class fields

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.MONITOR.clk);
      wait(vif.monitor_cb.Ain || vif.monitor_cb.Bin);
        @(posedge vif.MONITOR.clk);
        trans_collected.Ain = vif.monitor_cb.Ain;
        trans_collected.Bin = vif.monitor_cb.Bin;
        trans_collected.inDataA = vif.monitor_cb.inDataA;
        trans_collected.inDataB = vif.monitor_cb.inDataB;
        @(posedge vif.MONITOR.clk);
        @(posedge vif.MONITOR.clk);
        trans_collected.Aout = vif.monitor_cb.Aout;
        trans_collected.Bout = vif.monitor_cb.Bout;
        trans_collected.outDataA = vif.monitor_cb.outDataA;
        trans_collected.outDataB = vif.monitor_cb.outDataB;
      end
	  item_collected_port.write(trans_collected);
  endtask : run_phase

endclass : eth_monitor
