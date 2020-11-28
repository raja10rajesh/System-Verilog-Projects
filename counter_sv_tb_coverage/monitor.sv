class monitor;
  virtual intf vif;
  
  transaction trans;
  
  mailbox mon2scb;
  
  
  covergroup counter_cover;
	option.per_instance=1;  
    //option.get_inst_coverage = 1;
    input_ld_en: coverpoint trans.ld_en{bins low={0};  bins high={1};   }
	input_en   : coverpoint trans.en   {bins low={0};  bins high={1};   }
	input_updwn: coverpoint trans.updwn{bins low={0};  bins high={1};   }

			  
  endgroup

  function new(mailbox scb, virtual intf vif);
    this.mon2scb = scb;
    this.vif = vif;
    counter_cover=new();
  endfunction

  
  task run;
    begin
      trans = new();
      counter_cover.sample();
      @(posedge vif.clk);
      trans.ld_en = vif.ld_en;
      trans.updwn = vif.updwn;
      trans.en    = vif.en;
      trans.datain= vif.datain;
      
      trans.dataout=vif.dataout;
   	  counter_cover.sample();
      mon2scb.put(trans);
      trans.display("[ Monitor ]   ");
    end  
  endtask
  
endclass: monitor