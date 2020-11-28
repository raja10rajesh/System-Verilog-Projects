// Code your testbench here
// or browse Examples

`include "interface.sv"

`include "random_test.sv"

module tb_top;

  bit clk;
  bit rst_n;
  
  initial
  begin
    rst_n=0;
    clk =1'b1;
   forever #5 clk = ~clk;
  end
  
  
  
  
  intf i_intf(clk,rst_n);
  
  test t1(i_intf); 
   
  counter8b DUT (.clk(i_intf.clk),
                 .rst_n(i_intf.rst_n),
                 .ld_en(i_intf.ld_en),
                 .updwn(i_intf.updwn),
                 .en(i_intf.en),
                 .datain(i_intf.datain),
                 .dataout(i_intf.dataout)
                );
  
  
  initial 
  begin 
    $dumpfile("dump.vcd"); $dumpvars(1);
  end
  
endmodule