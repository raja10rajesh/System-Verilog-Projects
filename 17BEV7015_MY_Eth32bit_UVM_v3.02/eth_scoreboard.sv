

class eth_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(eth_scoreboard)
  // declaring pkt_qu to store the pkt's recived from monitor
  eth_seq_item pkt_qu[$];
  

  // sc_mem 
  bit [31:0] sc_eth [6];


  //port to recive packets from monitor
  uvm_analysis_imp#(eth_seq_item, eth_scoreboard) item_collected_export;



  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  
  // build_phase - create port and initialize local memory

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      item_collected_export = new("item_collected_export", this);
    foreach(sc_eth[i]) sc_eth[i] = 32'hFFFFFFFF;
  endfunction: build_phase
  

  // write task - recives the pkt from monitor and pushes into queue
  virtual function void write(eth_seq_item pkt);
    pkt.print();
    pkt_qu.push_back(pkt);
  endfunction : write


  // run_phase - compare's the read data with the expected data(stored in local memory)
virtual task run_phase(uvm_phase phase);
    eth_seq_item eth_pkt;
    forever 
    begin
      	wait(pkt_qu.size() > 0);
      	eth_pkt = pkt_qu.pop_front();
      
      	if(eth_pkt.Ain) 
      	begin
        	sc_eth[eth_pkt.inDataA] = eth_pkt.inDataA;
        		`uvm_info(get_type_name(),$sformatf("------ :: WRITE DATA       :: ------"),UVM_LOW)
        		`uvm_info(get_type_name(),$sformatf("inDataA: %0h",eth_pkt.inDataA),UVM_LOW)
        		`uvm_info(get_type_name(),"------------------------------------",UVM_LOW)      
      	end else if(eth_pkt.Aout) 
      	begin
        	if(sc_eth[eth_pkt.outDataA] == eth_pkt.outDataA) 
        	begin
          		`uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match on Port A:: ------"),UVM_LOW)
          		`uvm_info(get_type_name(),$sformatf("Data: %0h",eth_pkt.outDataB),UVM_LOW)
          		`uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_eth[eth_pkt.outDataA],eth_pkt.outDataA),UVM_LOW)
          		`uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        	end 
        end else if(eth_pkt.Bout)
      	begin
        	if(sc_eth[eth_pkt.outDataA] == eth_pkt.outDataB) 
            begin
           		`uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match on Port B:: ------"),UVM_LOW)
          		`uvm_info(get_type_name(),$sformatf("Data: %0h",eth_pkt.outDataB),UVM_LOW)
          		`uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_eth[eth_pkt.outDataA],eth_pkt.outDataB),UVM_LOW)
          		`uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
      		end
        end 
        
      	else if(eth_pkt.Bin) 
      	begin
        	sc_eth[eth_pkt.inDataB] = eth_pkt.inDataB;
        	`uvm_info(get_type_name(),$sformatf("------ :: WRITE DATA       :: ------"),UVM_LOW)
        	`uvm_info(get_type_name(),$sformatf("inDataA: %0h",eth_pkt.inDataB),UVM_LOW)
        	`uvm_info(get_type_name(),"------------------------------------",UVM_LOW)      
      	end else if(eth_pkt.Aout) 
      	begin
        	if(sc_eth[eth_pkt.outDataB] == eth_pkt.outDataA) 
        	begin
          	`uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match on Port B:: ------"),UVM_LOW)
          	`uvm_info(get_type_name(),$sformatf("Data: %0h",eth_pkt.outDataA),UVM_LOW)
          	`uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_eth[eth_pkt.outDataB],eth_pkt.outDataA),UVM_LOW)
          	`uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        	end  
      	end else if(eth_pkt.Bout) 
      	begin
        	if(sc_eth[eth_pkt.outDataB] == eth_pkt.outDataB) begin
            	`uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match on Port B:: ------"),UVM_LOW)
          		`uvm_info(get_type_name(),$sformatf("Data: %0h",eth_pkt.outDataB),UVM_LOW)
          		`uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_eth[eth_pkt.outDataB],eth_pkt.outDataB),UVM_LOW)
          		`uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        	end
      	end else  
      	begin
          `uvm_error(get_type_name(),"------ :: READ DATA MisMatch :: ------")
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
      	end
    end
endtask :run_phase
          
endclass :eth_scoreboard