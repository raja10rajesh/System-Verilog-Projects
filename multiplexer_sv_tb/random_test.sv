`include "environment.sv"

program test(intf A_intf);
  environment env;
  
  initial 
  begin
    env= new(A_intf);
    env.build;
    env.no_test = 4;
    env.run;
    #10 $finish;
  end
endprogram

  