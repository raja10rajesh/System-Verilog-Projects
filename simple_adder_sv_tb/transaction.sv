class transaction;
  
  rand bit[3:0] a;
  rand bit[3:0] b;
 	   bit[6:0] c;
  
  function void display(string name);
    //$display("-------------------------");
    $display("- %s a = %0d, b = %0d, c = %0d",name,a,b,c);
   // $display("-------------------------");
  endfunction
  
endclass : transaction
    