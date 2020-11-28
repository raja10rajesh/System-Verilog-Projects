`timescale 1ns / 1ps
//`include "ethernet_fsm.v"
module ethernet_switch
  (
    input clk,reset,
    input [31:0]dataIn_A,
    input [31:0]dataIn_B,
    output reg [31:0]dataOut_A,
    output reg [31:0]dataOut_B
  );
  parameter addr_portA=2'b01;
  parameter addr_portB=2'b10;
  
  //ethernet_fsm DUT(.clk(clk),.rst(rst),.load(load),.state(state));
  
  reg [31:0]input_temp_A;
  reg [31:0]output_temp_A;
  reg [31:0]input_temp_B;
  reg [31:0]output_temp_B;
  
  always@(posedge clk)
    begin
      if(reset)
        begin
        dataOut_A=32'b0;
        dataOut_B=32'b0;
        end
      else
        begin
          input_temp_A=dataIn_A;
          case(dataIn_A[31:30])
            addr_portA:
            begin
              output_temp_A=input_temp_A;
              dataOut_A=output_temp_A;
            end
            addr_portB:
            begin
              output_temp_A=input_temp_A;
              dataOut_B=output_temp_A;
            end
          endcase
        end
        end
  always@(posedge clk)
        begin
          if(reset)
            begin
            dataOut_A=32'b0;
            dataOut_B=32'b0;
            end
      else
        begin
           input_temp_B=dataIn_B;
           case(dataIn_B[31:30])
             addr_portA:
             begin
               output_temp_B=input_temp_B;
               dataOut_A=output_temp_B;
             end
             addr_portB:
             begin
               output_temp_B=input_temp_B;
               dataOut_B=output_temp_B;
             end
           endcase
        end
    end
  endmodule
