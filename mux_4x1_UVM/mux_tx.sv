class mux_tx extends uvm_sequence_item;
 // `uvm_component_utils(mux_tx)
	rand bit a;
	rand bit b;
    rand bit c;
	rand bit d;
         bit out;
    rand bit [1:0] select;

	`uvm_object_utils_begin(mux_tx)
		`uvm_field_int(a,UVM_ALL_ON)
		`uvm_field_int(b,UVM_ALL_ON)
  		`uvm_field_int(c,UVM_ALL_ON)
  		`uvm_field_int(d,UVM_ALL_ON)
        `uvm_field_int(out,UVM_ALL_ON)
		`uvm_field_int(select,UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name ="");
		super.new(name);
	endfunction
  
  constraint c_a{a dist{0:=3,1:=2};}
  constraint c_b{b dist{0:=2,1:=3};}
  constraint c_c{c dist{0:=3,1:=2};}
  constraint c_d{d dist{0:=2,1:=3};}
  constraint c_s0{select[0] dist{0:=1,1:=3};}
  constraint c_s1{select[1] dist{0:=5,1:=3};}
  
 

  
  
endclass
