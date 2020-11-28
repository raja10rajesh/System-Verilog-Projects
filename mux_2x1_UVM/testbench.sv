//link to 4x1 mux : https://www.edaplayground.com/x/4TRq

`include "uvm_pkg.sv"
import uvm_pkg::*;

`include "mux_intf.sv"
`include "mux_tx.sv"
`include "mux_coverage.sv"
`include "mux_monitor.sv"
`include "mux_sequencer.sv"
`include "mux_scoreboard.sv"
`include "mux_driver.sv"
`include "mux_agent.sv"
`include "mux_env.sv"
`include "mux_seq.sv"
`include "mux_base_test.sv"
`include "mux_test.sv"

module top;

mux_intf pif();
mux2x1 dut(.a(pif.x),.b(pif.y),.sel(pif.select),.out(pif.mux_out));

initial begin
	uvm_config_db#(virtual mux_intf)::set(uvm_root::get(),"","vif",pif);
  $dumpfile("dump.vcd"); 
  $dumpvars(1);
end

initial begin
	run_test();
end
endmodule
