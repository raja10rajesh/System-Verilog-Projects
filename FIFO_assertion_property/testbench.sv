// Code your testbench here
// or browse Examples
`include "fifo_property.sv"
`include "binding_file.sv"


  parameter FIFO_W = 32;
  parameter FIFO_D = 8;

module tester_fifo;
  reg clk,reset_n,write_en,read_en;
  reg [FIFO_W-1:0] data_in;
  wire empty,full;
  wire [FIFO_W-1:0] data_out;
  
 
  initial
  begin
      clk = 1'b0;
      reset_n=1'b1;      
      forever #5  clk = ~clk;
  end
  
  
  initial 
  begin
         reset_n = 1'b0; write_en = 1'b0; read_en = 1'b0; data_in = 32'h0;
    #10; reset_n = 1'b1; write_en = 1'b0; read_en = 1'b0; 
    #20; 			     write_en = 1'b0; read_en = 1'b1; 
    #10;                 write_en = 1'b1; read_en = 1'b1; data_in = 32'h126598AB; 
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h126598AB;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h106598A0;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h166998A1;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h126592A2;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h126598A8;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h156598AB;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h126F98A6;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h1C6598AB;
    #10;                 write_en = 1'b1; read_en = 1'b0; data_in = 32'h126598A5;
    #10;                 write_en = 1'b0; read_en = 1'b1; 
    #10;                 write_en = 1'b0; read_en = 1'b1; 
    #10; reset_n = 1'b0; write_en = 1'b0; read_en = 1'b1; 
    #10; reset_n = 1'b1; write_en = 1'b1; read_en = 1'b1; 
    
    
    $finish(2);
    end
  
  fifo#(.FIFO_D(FIFO_D),.FIFO_W(FIFO_D)) DUT(.clk(clk),
                                             .reset_n(reset_n),
                                             .write_en(write_en),
                                             .read_en(read_en),
                                             .data_in(data_in),
                                             .data_out(data_out),
                                             .empty(empty),
                                             .full(full)
                                            );
  
  always @ (posedge clk)
  begin
    $display("%t rst_n:%d,Write En:%d,Read En:%d,Data In:%d,DataOut:%d,Empty:%d,Full:%d",$time,reset_n,write_en,read_en,data_in,data_out,empty,full);
  end
  
  initial
    begin
      $dumpfile("counter.vcd");
      $dumpvars(1);
    end
  
endmodule
      
  
      