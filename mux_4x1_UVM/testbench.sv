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
  mux4x1 dut(.a(pif.x),
             .b(pif.y),
             .c(pif.v),
             .d(pif.z),
             .sel(pif.select),
             .out(pif.mux_out)
            );

initial begin
	uvm_config_db#(virtual mux_intf)::set(uvm_root::get(),"","vif",pif);
  $dumpfile("dump.vcd"); 
  $dumpvars(1);
end

initial begin
	run_test();
end
endmodule
