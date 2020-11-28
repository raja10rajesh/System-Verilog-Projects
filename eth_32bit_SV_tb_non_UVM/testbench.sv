`include "interface.sv"

//-------------------------[NOTE]---------------------------------
//Particular testcase can be run by uncommenting, and commenting the rest
`include "random_test.sv"
//`include "directed_test.sv"
//----------------------------------------------------------------

module tbench_top;
  
  //clock and reset signal declaration
  bit clk;
  bit reset;
  
  //clock generation
  always #5 clk = ~clk;
  
  //reset Generation
  initial begin
    reset = 1;
    #5 reset =0;
  end
  
  
  //creatinng instance of interface, inorder to connect DUT and testcase
  intf i_intf(clk,reset);
  
  //Testcase instance, interface handle is passed to test as an argument
  test t1(i_intf);
  
  //DUT instance, interface signals are connected to the DUT ports
  ethernet_switch DUT (
    .clk(i_intf.clk),
    .reset(i_intf.reset),
    .dataIn_A(i_intf.dataIn_A),
    .dataIn_B(i_intf.dataIn_B),
    .dataOut_A(i_intf.dataOut_A),
    .dataOut_B(i_intf.dataOut_B)
    
   );
  
  //enabling the wave dump
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule