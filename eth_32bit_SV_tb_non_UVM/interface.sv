interface intf(input logic clk,reset);
  logic [31:0]dataIn_A;
  logic [31:0]dataIn_B;
  logic [31:0]dataOut_A;
  logic [31:0]dataOut_B;
  
  /*function void display();
    $display("START");
	$display($time,dataIn_A,dataIn_B,dataOut_A,dataOut_B);
	$display("END");
	endfunction*/
  
	endinterface