// Code your design here
module ethernet_fsm
  (
    input clk,rst,
    input load,
    output reg state
  );
  parameter idle=1'b0;
  parameter busy=1'b1;
  
  reg current_state,next_state;
  always@(posedge clk)
    begin
      if(rst)
        current_state<=idle;
      else
        current_state<=next_state;
    end
  always@(current_state,load)
    begin
      next_state=current_state;
      case(current_state)
        idle:
         if(load)
          begin
            next_state=busy;
            state=1'b1;
          end
        busy:
          if(~load)
            begin
              next_state=idle;
              state=1'b0;
            end
      endcase
   end
endmodule