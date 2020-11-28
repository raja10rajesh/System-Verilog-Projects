// Code your design here
//`timescale 1ns/ 1ps;
module counter8b (clk,rst_n,ld_en,updwn,en,datain,dataout);
  
  input clk, rst_n,ld_en,updwn,en;           
  input  [7:0] datain;
  output [7:0] dataout;
  reg    [7:0] sdataout;
  
  always @(posedge clk)
    begin
      //if(!rst_n)
        //sdataout=8'b0;
    //else 
      if(ld_en)
          sdataout=datain;
    else if(!en)
          sdataout=sdataout;
    else if (updwn)
       	   sdataout=sdataout+1;
      	   else
           sdataout=sdataout-1;
     end
  assign dataout=sdataout;
endmodule
          
            