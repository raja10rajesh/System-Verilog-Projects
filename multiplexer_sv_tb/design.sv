// Code your design here
module mux(out,sel,a,b);
input [3:0] a;
input [3:0] b;
input sel;
output [3:0] out;
reg [3:0] out;

  always@(a,b,sel) 
 begin
   out <= (sel)?a:b;
 end
endmodule