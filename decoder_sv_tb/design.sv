// Code your design here
module decoder3x8(in,out,en);
  input [2:0] in;
  input en;
  output [7:0] out;
  reg [7:0] out;
  
  always@(en,in)
  begin
    out = (en)?(8'b1<<in):8'b0;
  end
  
endmodule
  
  