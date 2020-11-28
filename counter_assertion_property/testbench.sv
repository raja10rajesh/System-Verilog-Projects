// Code your testbench here
// or browse Examples
`include "counter_property.sv"
`include "binding_file.sv"

module tester;
  reg clk,rst_n,ld_en,updwn,en;
  reg [7:0] datain;
  wire [7:0] dataout;
  
  
  
  /* bind counter8b counter_property inst(.clk(clk),
                                       .rst_n(rst_n),
                                       .ld_en(ld_en),
                                       .updwn(updwn),
                                       .en(en),
                                       .datain(datain),
                                       .dataout(dataout)
                                      );
  */
  
  initial
  begin
      clk = 1'b1;
      rst_n=1'b1;      
      forever #5  clk = ~clk;
  end
  
  initial 
  begin
        rst_n=1'b1;ld_en=1'b1; datain=8'd255; updwn=1'b1;en=1'b1;
    #20;rst_n=1'b0;ld_en=1'b0; datain=8'd0;   updwn=1'b0;en=1'b0;
    #10;rst_n=1'b1;ld_en=1'b0; datain=8'd0;   updwn=1'b1;en=1'b1;
    #20;           ld_en=1'b0;
    #30;                                      updwn=1'b1;en=1'b1;              
    #40;          ld_en=1'b0;                updwn=1'b0;en=1'b0;
    #50;          ld_en=1'b1; datain=8'd63;  updwn=1'b0;en=1'b1;
    #10;           ld_en=1'b0;                updwn=1'b1;en=1'b1;       
    #100;                                                en=1'b0;
    #50;
    $finish(2);
    end
  
  counter8b DUT(.clk(clk),
                .rst_n(rst_n),
                .ld_en(ld_en),
                .updwn(updwn),
                .en(en),
                .datain(datain),
                .dataout(dataout)
               );
  
  always @ (posedge clk)
  begin
    $display("%t Load_en:%d, Up_down:%d,en:%d, Datain:%d, Data_out:%d",$time,ld_en,updwn,en,datain,dataout);
  end
  
  initial
    begin
      $dumpfile("counter.vcd");
      $dumpvars(1);
    end
  
endmodule
      
  
      