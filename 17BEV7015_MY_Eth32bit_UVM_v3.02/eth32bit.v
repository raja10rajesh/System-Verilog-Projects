module eth32bit(clk,rst_n,inDataA,inDataB,outDataA,outDataB,Ain,Bin,Aout,Bout);
input clk,rst_n,Ain,Bin;
input [31:0] inDataA;
input [31:0] inDataB;
output [31:0] outDataA;
output [31:0] outDataB;
output Aout,Bout;

reg [31:0] outDataA;
reg [31:0] outDataB;
reg Aout,Bout;

reg [31:0] DataRcvd_A;
reg [31:0] DataRcvd_B;

parameter addr_portA= 2'b01;
parameter addr_portB= 2'b10;


always @(posedge clk)
begin
    if(!rst_n)
    begin
        outDataA <= 32'b0;
        outDataA  <= 32'b0;
        Aout     <= 0;
        Bout     <= 0;
      $display("%t [RESET] values on outDataA:%b outDataA:%b Aout:%b Bout:%b",$time,outDataA, outDataA, Aout, Bout);
    end
end

always @(posedge clk)
begin
    if(Ain==1'b1)
    begin
        DataRcvd_A<=inDataA;
      $display("%t [[DUT]] \t[Port A] data received on A is: %b",$time,DataRcvd_A);
        if(DataRcvd_A[31:30] == addr_portA)
        begin
            Aout<=1'b1;
            outDataA<=DataRcvd_A;
          $display("%t [[DUT]] \t[Port A]: data received on A is sent to [Port A]",$time);
            Aout<=1'b0;
        end if(DataRcvd_A[31:30] == addr_portB)
        begin
            Bout<=1'b1;
            outDataB<=DataRcvd_A;
          $display("%t [[DUT]] \t[Port A]: data received on A is sent to [Port B]",$time);
            Bout<=1'b0;
        end if((DataRcvd_A[31:30] != addr_portB)&&(DataRcvd_A[31:30] == addr_portA))
        begin
          $display("%t [[DUT]] \t[Port A]: dropping packed, not a valid address",$time);
        end  
    end else
    begin
        DataRcvd_A<= DataRcvd_A;
      $display("%t [[DUT]] \t[Port A]: no data received",$time);
    end
end    
    
    
always @(posedge clk)
begin
    if(Bin==1'b1)
    begin
        DataRcvd_B<=inDataB;
      $display("%t [[DUT]] \t[Port B] data received on B is: %b",$time,DataRcvd_B);
        if(DataRcvd_B[31:30] == addr_portB)
        begin
            Bout<=1'b1;
            outDataB<=DataRcvd_B;
          $display("%t [[DUT]] \t[Port B]: data received on B is sent to [Port B]",$time);
            Bout<=1'b0;
        end if(DataRcvd_B[31:30] == addr_portA)
        begin
            Aout<=1'b1;
            outDataA<=DataRcvd_B;
          $display("%t [[DUT]] \t[Port B]: data received on B is sent to [Port A]",$time);
            Aout<=1'b0;
        end if((DataRcvd_B[31:30] != addr_portB)&&(DataRcvd_B[31:30] == addr_portA))
        begin
          $display("%t [[DUT]] \t[Port B]: dropping packed, not a valid address",$time);
        end  
    end else
    begin
        DataRcvd_B<= DataRcvd_B;
      $display("%t [[DUT]] \t[Port B]: no data received",$time);
    end
end 
    
endmodule    