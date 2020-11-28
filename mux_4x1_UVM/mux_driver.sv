class mux_driver extends uvm_driver#(mux_tx);
	`uvm_component_utils(mux_driver)
  
  
	function new(string name="",uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual mux_intf vif;
	mux_tx tx;

  
  //build phase
	function void build_phase(uvm_phase phase);
		if(!(uvm_config_db#(virtual mux_intf)::get(this,"","vif",vif))) begin
			`uvm_fatal("driver","unable to get interface")
		end
	endfunction
  
  
//run_phase
	task run_phase(uvm_phase phase);
		forever begin;
			seq_item_port.get_next_item(tx);
			vif.select = tx.select;
			vif.x = tx.a;
			vif.y = tx.b;
            vif.v = tx.c;
			vif.z = tx.d;
            tx.out = vif.mux_out;
          //$display("PKT:DRIVER");
			//tx.print();
			seq_item_port.item_done();

		end
	endtask :run_phase
endclass
