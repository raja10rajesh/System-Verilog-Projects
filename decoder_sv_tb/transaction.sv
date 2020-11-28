class transaction;
  
  rand bit [2:0]  in;
  bit [7:0] out;
  rand bit en;
      
  constraint en_c{en dist {0:=2,1:=8};}
 
  
  
  function void display(string name);
    //$display("-------------------------");
    $display("- %s in = %0b, en = %0b, out = %0b ",name,in,en,out);
    //$display("-------------------------");
  endfunction
  
endclass : transaction
    