module mux4x1(a,b,c,d,out,sel);
  input a,b,c,d;
  input [1:0]sel;
  output out;
  reg out;
  
  always@(sel)
  begin
    out = sel[0]?(sel[1]?d:c):(sel[1]?b:a);
  end
endmodule