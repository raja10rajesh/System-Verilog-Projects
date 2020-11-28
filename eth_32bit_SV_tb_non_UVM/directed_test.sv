`include "environment.sv"
program test(intf i_intf);
  
  class my_trans extends eth_trans;
    
    bit [1:0] count;
    
    function void pre_randomize();
      dataIn_A.rand_mode(0);
      dataIn_B.rand_mode(0);          

      dataIn_A = 32'b10101111111100001010101010111000 ;
      dataIn_B = 32'b01101000111100001010101010111000;
    endfunction
    
  endclass
    
  //declaring environment instance
  eth_env env;
  my_trans my_tr;
  
  initial begin
    //creating environment
    env = new(i_intf);
    
    my_tr = new();
    
    //setting the repeat count of generator as 4, means to generate 4 packets
    env.gen.repeat_count = 10;
    
    env.gen.trans = my_tr;
    
    //calling run of env, it interns calls generator and driver main tasks.
    env.run();
  end
endprogram