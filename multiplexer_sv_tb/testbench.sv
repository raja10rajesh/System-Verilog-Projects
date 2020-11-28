// Code your testbench here
// or browse Examples

`include "interface.sv"

`include "random_test.sv"

module tb_top;
  intf i_intf();
  
  test t1(i_intf); 
   
  
  mux DUT (.out(i_intf.out),
           .sel(i_intf.sel),
           .a(i_intf.a),
           .b(i_intf.b)
          );
  
  initial 
  begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
endmodule