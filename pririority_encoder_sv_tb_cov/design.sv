// Code your design here
module pri_enc8x3(A, Y);
  input [7:0]Y;
  output [2:0] A;
  reg [2:0]A;
  
  always@(Y)
  begin
    casex(Y)

  8'b00000001:A = 3'b000;
  8'b0000001x:A = 3'b001;
  8'b000001xx:A = 3'b010;
  8'b00001xxx:A = 3'b011;
  8'b0001xxxx:A = 3'b100;
  8'b001xxxxx:A = 3'b101;
  8'b01xxxxxx:A = 3'b110;
  8'b1xxxxxxx:A = 3'b111;

    default:$display("Error!");
    endcase
 end
  
endmodule