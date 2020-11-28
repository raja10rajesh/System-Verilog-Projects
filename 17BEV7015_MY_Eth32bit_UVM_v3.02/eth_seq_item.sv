
class eth_seq_item extends uvm_sequence_item;

  //data and control fields

  rand bit        Ain;
  rand bit        Bin;
  rand bit [31:0] inDataA;
  rand bit [31:0] inDataB;
   	   bit [31:0] outDataA;
       bit [31:0] outDataB;
       bit        Aout;
       bit		  Bout;
  


  `uvm_object_utils_begin(eth_seq_item)
    `uvm_field_int(Ain,UVM_ALL_ON)
    `uvm_field_int(Bin,UVM_ALL_ON)
  	`uvm_field_int(inDataA,UVM_ALL_ON)
  	`uvm_field_int(inDataB,UVM_ALL_ON)
  	`uvm_field_int(outDataA,UVM_ALL_ON)
  	`uvm_field_int(outDataB,UVM_ALL_ON)
  	`uvm_field_int(Aout,UVM_ALL_ON)
  	`uvm_field_int(Bout,UVM_ALL_ON)
  	`uvm_object_utils_end
  

  //Constructor

  function new(string name = "eth_seq_item");
    super.new(name);
  endfunction
  
  
endclass