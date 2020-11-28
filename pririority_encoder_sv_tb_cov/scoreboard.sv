class scoreboard;
  mailbox mon2scb;
  transaction trans;
  transaction temp;
  
  function new(mailbox mon);
    this.mon2scb =mon;
  endfunction
  
  task run;
    mon2scb.get(trans);
    temp=trans;
    trans.display("[ Scoreboard ]");
    temp.out[2]= trans.Y[7] || trans.Y[6] || trans.Y[5] || trans.Y[4];
    temp.out[1]=trans.Y[7] || trans.Y[6] ||((~trans.Y[5] & ~trans.Y[4]) & (trans.Y[3]||trans.Y[2]));
    temp.out[0]=trans.Y[7] || (~trans.Y[6]& trans.Y[5])||((~trans.Y[6] & ~trans.Y[4])&(trans.Y[3]||(~trans.Y[2]&trans.Y[1])));
    if(temp.out==trans.out)
      $info("*****************Perfect!! Working******************");
    else
      $error("*****************Failed!! Not-Working******************");
  endtask
      
    
  
/*  task run;
    mon2scb.get(trans);
    trans.display("[ Scoreboard ]");
    case(trans.Y)
      8'b00000001: if(trans.out == 3'b000) $display("**Matched**"); else $fatal("mismatch case 1");
      8'b0000001x: if(trans.out == 3'b001) $display("**Matched**"); else $fatal("mismatch case 2");
      8'b000001xx: if(trans.out == 3'b010) $display("**Matched**"); else $fatal("mismatch case 3");
      8'b00001xxx: if(trans.out == 3'b011) $display("**Matched**"); else $fatal("mismatch case 4");
      8'b0001xxxx: if(trans.out == 3'b100) $display("**Matched**"); else $fatal("mismatch case 5");
      8'b001xxxxx: if(trans.out == 3'b101) $display("**Matched**"); else $fatal("mismatch case 6");
      8'b01xxxxxx: if(trans.out == 3'b110) $display("**Matched**"); else $fatal("mismatch case 7");
      8'b1xxxxxxx: if(trans.out == 3'b111) $display("**Matched**"); else $fatal("mismatch case 8");
      default : $display("***No case Satisfied***");
    endcase
  endtask
 */ 
endclass:scoreboard