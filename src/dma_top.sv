`include "uvm_macros.svh"
 import uvm_pkg::*;
`include "ral_pkg.sv"
`include "../rtl/design.v"
module dma_top();
	bit clk, rst_n;
	dma_intf intf(clk, rst_n);

dma_design dut (.clk(clk),
				.rst_n(rst_n),
				.addr(intf.addr),
				.wr_en(intf.wr_en),
				.rd_en(intf.rd_en),
				.wdata(intf.wdata),
				.rdata(intf.rdata));

	always 
		#5 clk = ~clk;

	initial
		clk = 0;

	initial
	begin
		uvm_config_db #(virtual dma_intf)::set(null, "*", "vif", intf); 
		uvm_config_db #(virtual dma_intf.MONITOR)::set(null, "*", "vif", intf.MONITOR); 
		rst_n = 0;
		@(posedge clk) 
		rst_n = 1; 
	end

	initial
	begin
		run_test("all_reg_reset_test");
	end

endmodule
