
interface eth_if(input logic clk,rst_n);
  

  //declaring the signals

  logic        Ain;
  logic        Bin;
  logic [31:0] inDataA;
  logic [31:0] inDataB;
  logic [31:0] outDataA;
  logic [31:0] outDataB;
  logic        Aout;
  logic		   Bout;
  

  //driver clocking block

  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    
    output      Ain;
  	output      Bin;
  	output 		inDataA;
  	output 		inDataB;
  	input 		outDataA;
  	input  		outDataB;
  	input       Aout;
    input		Bout;  
    
  endclocking
  

  //monitor clocking block

  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input       Ain;
  	input       Bin;
  	input 		inDataA;
  	input 		inDataB;
  	input 		outDataA;
  	input  		outDataB;
  	input       Aout;
    input		Bout;
  endclocking
  

  //driver modport

  modport DRIVER  (clocking driver_cb,input clk,rst_n);
  

  //monitor modport  

  modport MONITOR (clocking monitor_cb,input clk,rst_n);
  
endinterface