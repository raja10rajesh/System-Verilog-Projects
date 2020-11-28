// Code your design here
module adder(a,b,c); 
  input  [3:0] a;
  input  [3:0] b;
  output [6:0] c;
  reg [7:0] c;
    
  always@(a,b)
  begin
    c <= a + b;
  end

endmodule