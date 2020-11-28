class monitor;
  virtual intf vif;
  transaction trans;
  mailbox mon2scb;
  
  
  covergroup p_enc_cover;
	option.per_instance=1;  
    //option.get_inst_coverage = 1;
    input_Y7: coverpoint trans.Y[7]{bins low={0};  bins high={1};   }
	input_Y6: coverpoint trans.Y[6]{bins low={0};  bins high={1};   }
	input_Y5: coverpoint trans.Y[5]{bins low={0};  bins high={1};   }
	input_Y4: coverpoint trans.Y[4]{bins low={0};  bins high={1};   }
	input_Y3: coverpoint trans.Y[3]{bins low={0};  bins high={1};   }
    input_Y2: coverpoint trans.Y[2]{bins low={0};  bins high={1};   }
	input_Y1: coverpoint trans.Y[1]{bins low={0};  bins high={1};   }
	input_Y0: coverpoint trans.Y[0]{bins low={0};  bins high={1};   }
			  
	output_out2: coverpoint trans.out[2]{bins low={0};  bins high={1};   }
	output_out1: coverpoint trans.out[1]{bins low={0};  bins high={1};   }
	output_out0: coverpoint trans.out[0]{bins low={0};  bins high={1};   }
			  
  endgroup
  
  
  
  function new(mailbox scb, virtual intf vif);
    this.mon2scb = scb;
    this.vif = vif;
    p_enc_cover=new();
  endfunction

  
  task run;
      trans = new();
      p_enc_cover.sample();
      //wait(vif.out);
      trans.Y = vif.Y;
      trans.out = vif.out;
   	  p_enc_cover.sample();
      mon2scb.put(trans);
      trans.display("[ Monitor ]   ");
  endtask
  
endclass: monitor