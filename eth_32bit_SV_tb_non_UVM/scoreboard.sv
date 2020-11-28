class scoreboard;
 
  //creating mailbox handle
  mailbox mon2scb;
  
  //used to count the number of transactions
  int no_transactions;
  
  //constructor
  function new(mailbox mon2scb);
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
  endfunction
  
  //Compares the Actual result with the expected result
  task main;
    eth_trans trans;
    forever begin
      mon2scb.get(trans);
      if((trans.dataIn_A[31:30]==2'b01) && (trans.dataOut_A==trans.dataIn_A) || (trans.dataIn_A[31:30]==2'b10 )&& (trans.dataOut_B==trans.dataIn_A) || (trans.dataIn_B[31:30]==2'b01) && (trans.dataOut_A==trans.dataIn_B)|| (trans.dataIn_B[31:30]==2'b10) && (trans.dataOut_B==trans.dataIn_B))
         $display("Result is as Expected");
        else
         $display("Wrong Result");
      no_transactions++;
      trans.display("[ Scoreboard ]");
    end
  endtask
  
endclass