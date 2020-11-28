// Code your testbench here
// or browse Examples

`include "interface.sv"

`include "random_test.sv"

module tb_top;
  intf i_intf();
  
  test t1(i_intf); 
   
  
  decoder3x8 DUT(.in(i_intf.in),
                  .out(i_intf.out),
                  .en(i_intf.en)
                 );
  
  initial 
  begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
endmodule