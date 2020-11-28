class eth_trans;
  
  //declaring the transaction items
  rand bit reset;
  rand bit [31:0] dataIn_A;
  rand bit [31:0] dataIn_B;
  bit [31:0] dataOut_A;
  bit [31:0] dataOut_B;
  function void display(string name);
    $display("-------------------------");
    $display("- %s ",name);
    $display("-------------------------");
    $display("- A = %0b, B = %0b",dataIn_A,dataIn_B);
    $display("- A = %0b, B = %0b",dataOut_A,dataOut_B);
    $display("-------------------------");
  endfunction
endclass :eth_trans