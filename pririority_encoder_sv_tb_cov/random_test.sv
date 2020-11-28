`include "environment.sv"

program test(intf A_intf);
  environment env;
  
  
  initial 
  begin
    env= new(A_intf);
    env.build;
    env.no_test = 10;
    env.run;
    #100 $finish;
  end
endprogram

  