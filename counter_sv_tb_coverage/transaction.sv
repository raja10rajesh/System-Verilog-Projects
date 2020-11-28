class transaction;
  
  rand bit       ld_en;
  rand bit       updwn;
  rand bit       en;
  rand bit [7:0] datain;
       bit [7:0] dataout;

  constraint ld { ld_en != en;}
  constraint en_c { en dist{1:=10, 0:=2};}
  constraint up_c { updwn dist{1:=12, 0:=2};}


  function void display(string name);
    //$display("-------------------------");
    $display("- %s ld_en = %b, updwn = %b en = %b datain = %d dataout = %d",name,ld_en,updwn,en,datain,dataout);
    //$display("-------------------------");
  endfunction
  
  

endclass : transaction
    