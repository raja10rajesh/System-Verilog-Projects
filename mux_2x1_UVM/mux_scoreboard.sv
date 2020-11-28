class mux_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(mux_scoreboard)
  
  uvm_analysis_imp#(mux_tx, mux_scoreboard) item_collected_export;
  mux_tx tr;

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this); //creating port
    tr = mux_tx::type_id::create("tr",this);
  endfunction: build_phase
  
// write task - recives the pkt from monitor and pushes into queue
  virtual function void write(mux_tx pkt);
    $display("SCB:: Pkt recived");
    //pkt.print();
    this.tr = pkt;
  endfunction : write
  
  //run phase
  virtual task run_phase(uvm_phase phase);
    forever 
    begin
      @(tr.select)
      `uvm_info(get_type_name(),$sformatf("a= %b,b=%b,sel=%b,out=%b",tr.a,tr.b,tr.select,tr.out),UVM_HIGH)
      if(tr.select == 1'b0)
      begin  
        if(tr.out == tr.b)          
          `uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match :: ------"),UVM_HIGH)
        else
          `uvm_info(get_type_name(),$sformatf("------ :: READ DATA MIS Match :: ------"),UVM_HIGH)
      end 
      if(tr.select == 1'b1)
      begin  
        if(tr.out == tr.a)
          `uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match :: ------"),UVM_HIGH)
        else
          `uvm_info(get_type_name(),$sformatf("------ :: READ DATA MIS Match :: ------"),UVM_HIGH)
      end
    end
  endtask
      
          
            
        
    
  
endclass : mux_scoreboard
    