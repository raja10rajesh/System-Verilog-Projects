// Code your testbench here
// or browse Examples

`include "interface.sv"

`include "random_test.sv"

module tb_top;
  intf i_intf();
  
  test t1(i_intf); 
   
  
  adder DUT (
    .a(i_intf.a),
    .b(i_intf.b),
    .c(i_intf.c)
   );
  
  initial 
  begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
endmodule