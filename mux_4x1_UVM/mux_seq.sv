class mux_seq extends uvm_sequence#(mux_tx);
	`uvm_object_utils(mux_seq)

  function new(string name="");
		super.new(name);
  endfunction
  `uvm_declare_p_sequencer(mux_sequencer)
  mux_tx txn;
  
  virtual task body();
    repeat(5)
    begin
      txn = mux_tx::type_id::create(.name("txn"),.contxt(get_full_name()));
      //start_item(txn);
      wait_for_grant();
      txn.constraint_mode(1);
	  assert(txn.randomize());
      send_request(txn);
      wait_for_item_done();
     //finish_item(txn);
    end
	endtask
endclass


/*
class mux_seq10 extends uvm_sequence#(mux_tx);
  `uvm_object_utils(mux_seq10)
  
    function new(string name = "mux_seq10");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
    begin
    `uvm_do(req)
    end
  endtask
endclass
  */
 


/*

class mux_seq10 extends mux_seq;
	`uvm_object_utils(mux_seq10)
		mux_tx txn;
	function new(string name="");
		super.new(name);
		txn = new();
	endfunction
	task body();
		start_item(txn);
		repeat(10) 
        begin
		  assert(txn.randomize());
		end
		finish_item(txn);
	endtask
endclass
*/

/*
class mux_seqa extends mux_seq;
	`uvm_object_utils(mux_seqa)
		mux_tx txn;
	function new(string name="");
		super.new(name);
		txn = new();
	endfunction
	task body();
		start_item(txn);
		repeat(10) 
        begin	
		  assert(txn.randomize() with {a==1;});
		end
		finish_item(txn);
	endtask
    
    
  


endclass 
  */
