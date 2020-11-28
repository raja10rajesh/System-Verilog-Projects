interface intf(input logic clk,rst_n);
  
  //declaring the signals
  logic       ld_en;
  logic       updwn;
  logic       en;
  logic [7:0] datain;
  logic [7:0] dataout;
  
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output ld_en;
    output updwn;
    output en;
    output datain;
    input  dataout;  
  endclocking
  

  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input ld_en;
    input updwn;
    input en;
    input datain;
    input  dataout;  
  endclocking

  //driver modport
  modport DRIVER  (clocking driver_cb,input clk,rst_n);
  
  //monitor modport  
   modport MONITOR (clocking monitor_cb,input clk,rst_n);

  
endinterface