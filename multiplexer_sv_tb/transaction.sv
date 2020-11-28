class transaction;
  
  rand bit [3:0] a;
  rand bit [3:0] b;
  rand bit sel;
       bit [3:0] out;
  
  function void display(string name);
    //$display("-------------------------");
    $display("- %s a = %0d, b = %0d, sel = %0d , out = %0d",name,a,b,sel,out);
   // $display("-------------------------");
  endfunction
  
endclass : transaction
    