//including interfcae and testcase files
`include "eth_interface.sv"
`include "eth_base_test.sv"
`include "eth_wr_rd_test.sv"
//---------------------------------------------------------------

module tbench_top;


  bit clk;
  bit rst_n;
  

  //clock generation

  always #10 clk = ~clk;
  

  //reset Generation

  initial begin
    rst_n = 0;
    #50 rst_n =1;
  end
  

  //interface instance

  eth_if intf(clk,rst_n);
  

  eth32bit DUT(
    .clk(intf.clk),
    .rst_n(intf.rst_n),
    .inDataA(intf.inDataA),
    .inDataB(intf.inDataB),
    .outDataA(intf.outDataA),
    .outDataB(intf.outDataB),
    .Ain(intf.Ain),
    .Bin(intf.Bin),
    .Aout(intf.Aout),
    .Bout(intf.Bout)
  );
  
 

  //passing the interface handle to lower heirarchy using set method 
  //and enabling the wave dump

  initial begin 
    uvm_config_db#(virtual eth_if)::set(uvm_root::get(),"*","vif",intf);
    //enable wave dump
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  

  //calling test

  initial begin 
    run_test();
  end
  
endmodule