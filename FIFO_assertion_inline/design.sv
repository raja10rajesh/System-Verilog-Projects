module fifo(clk,reset_n,write_en,read_en,data_in,data_out,empty,full);
  parameter FIFO_W = 32;
  parameter FIFO_D = 8;

  input  clk,reset_n,write_en,read_en;
  input [FIFO_W-1:0] data_in;
  output [FIFO_W-1:0] data_out;
  output empty,full;

  wire clk; 
  wire write_en; 
  wire read_en; 
  wire [FIFO_W-1:0] data_in; 
  wire [FIFO_W-1:0] data_out;
  
  wire empty; 
  wire full;
  
  
  reg [FIFO_W-1:0] mem[0:(FIFO_D-1)]; 
  reg tmp_empty; 
  reg tmp_full;
  reg [FIFO_W-1:0] temp_data_out;

  integer front_ptr;
  integer end_ptr;

  
  
  
  always @(posedge clk)
  begin
    if(!reset_n)
    begin
      temp_data_out = 0;
      tmp_empty = 1'b1; 
      tmp_full = 1'b0; 
      front_ptr = 0; 
      end_ptr = 0;
    end
    else
    begin
      if((write_en == 1'b1) && (full == 1'b0))
      begin
        mem[front_ptr] = data_in;
        tmp_empty = 1'b0;
        front_ptr = (front_ptr+1) % FIFO_D;
        if(end_ptr == front_ptr)
        begin
          tmp_full = 1'b1;
        end
      end
      
      if((read_en == 1'b1) && (empty == 1'b0))
      begin
        temp_data_out = mem[end_ptr];
        tmp_full = 1'b0;
        end_ptr= (end_ptr+1) % FIFO_D;
        if(end_ptr == front_ptr)
        begin
          tmp_empty =1'b1;
        end
      end
      
      if((read_en == 1'b1) && (empty == 1'b1))
        temp_data_out = 32'bx;
    end
  end  
  
  assign empty = tmp_empty; 
  assign full = tmp_full; 
  assign data_out = temp_data_out;

endmodule
