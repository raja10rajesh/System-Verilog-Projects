class transaction;
  
  rand bit [7:0]  Y;
  	   bit [2:0] out;

 // constraint in_c{Y inside{00000001,00000010,00000100,00001000,00010000,00100000,01000000,10000000,00000000};}
  
  constraint c_Y8{Y>128;}
  constraint c_Y7{Y<127;  Y>63;}
  constraint c_Y6{Y<64 ;  Y>31;}
  constraint c_Y5{Y<32 ;  Y>15;}
  constraint c_Y4{Y<15 ;  Y>7; }
  constraint c_Y3{Y<8  ;  Y>3; }
  constraint c_Y2{Y<4  ;  Y>1; }
  constraint c_Y1{Y==1 ;} 
  
 
 

  function void display(string name);
    //$display("-------------------------");
    $display("- %s in = %b, out = %b ",name,Y,out);
    //$display("-------------------------");
  endfunction
  
  function void deep_copy(transaction t);
    this.Y = t.Y;
    this.out = t.out;
    //return temp;
  endfunction:deep_copy
    
    
  
endclass : transaction
    