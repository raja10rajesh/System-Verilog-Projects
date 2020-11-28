

module binding_module();
  bind counter8b counter_property asset_prop(.clk(clk),
                                             .rst_n(rst_n),
                                             .ld_en(ld_en),
                                             .updwn(updwn),
                                             .en(en),
                                             .datain(datain),
                                             .dataout(dataout)
                                            );
  
endmodule