

module binding_module();
  bind fifo fifo_property asset_prop(.clk(clk),
                                     .reset_n(reset_n),
                                     .write_en(write_en),
                                     .read_en(read_en),
                                     .data_in(data_in),
                                     .data_out(data_out),
               						 .empty(empty),
               						 .full(full)
              						);
  
endmodule