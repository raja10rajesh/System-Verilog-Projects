// Code your design here
//this file includes top module,fifomodule and fsm.
//////////////////////////////////////////////////////////////////////////////////
// Company: VITAP
// Engineer:  Rajesh K
// 
// Create Date: 15.05.2020 16:08:03
// Design Name:  Project_17BEV7015
// Module Name: eth_sw2x2
// Project Name: design and verification of Ethernet switch
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module eth_fsm(clk,reset_n,inData,inSop,inEop,outWrEn,outData);

input clk,reset_n,inSop,inEop;
input [31:0] inData;
output outWrEn;
output[33:0] outData;

reg outWrEn;
reg [33:0] outData;

parameter PORTA_ADDR = 'hABCD;
parameter PORTB_ADDR = 'hBEEF;


reg[2:0] nState;
reg[2:0] pState;

parameter IDLE = 3'b000;
parameter DEST_ADDR_RCVD = 3'b001;
parameter DATA_RCV = 3'b010;
parameter DONE = 3'b011;

reg[31:0] dest_addr;
reg[31:0] src_addr;
reg[33:0] data_word;
reg inSop_d;
reg inEop_d;
reg[31:0] inData_d;


always @(pState or inSop or inEop or inData ) begin
  nState = IDLE;
  case(pState) 
    IDLE: begin
      if(inSop ==1) begin
        dest_addr=inData;
        nState = DEST_ADDR_RCVD;
      end else begin
        nState = IDLE;
      end
    end
    DEST_ADDR_RCVD: begin
      src_addr = inData;
      nState=DATA_RCV;
    end
    DATA_RCV: begin
      if(inEop) begin 
        nState = DONE;
      end else begin
        nState = DATA_RCV;
      end
    end
    DONE: begin
        nState = IDLE;
    end
  endcase
end


always @(posedge clk) begin
  pState <= nState;
  inSop_d <= inSop;
  inEop_d <= inEop;
  inData_d <= inData;
end

always @(posedge clk) begin
  if(reset_n==0) begin
    outWrEn <=1'b0;
  end else if(pState != IDLE) begin
    outWrEn <=1'b1;
    outData = {inEop_d, inSop_d, inData_d};
  end else begin
    outWrEn <=1'b0;
  end
end

endmodule