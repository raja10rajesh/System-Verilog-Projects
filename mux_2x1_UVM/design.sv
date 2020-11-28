//link to 4x1 mux: https://www.edaplayground.com/x/4TRq

module mux2x1(a,b,out,sel);
  input a,b,sel;
  output out;
  reg out;
  
  always@(sel)
  begin
    out = sel?b:a;
  end
endmodule