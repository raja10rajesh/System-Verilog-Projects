// Code your testbench here
// or browse Examples

`include "interface.sv"

`include "random_test.sv"

module tb_top;
  intf i_intf();
  
  test t1(i_intf); 
   
  
  pri_enc8x3 DUT(.A(i_intf.out), 
                 .Y(i_intf.Y));
  
  initial 
  begin 
    $dumpfile("dump.vcd"); $dumpvars(1);
  end
  
endmodule