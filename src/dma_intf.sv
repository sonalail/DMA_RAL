`include "defines.svh"
interface dma_intf(input bit clk, rst_n);

	//Inputs
	logic wr_en;
	logic rd_en;
	logic [`DATA_WIDTH-1:0] wdata;
	logic [`ADDR_WIDTH-1:0] addr;
	
	//Outputs
	logic [`DATA_WIDTH-1:0] rdata;	
	
	clocking driver_cb @(posedge clk);
		default input #1ns output #1ns;
		output wr_en;
		output rd_en;
		output wdata;
		output addr;
		input  rdata;
	endclocking 

	clocking monitor_cb @(posedge clk);
		input wr_en;
		input rd_en;
		input wdata;
		input addr;
		input rdata;
		input rst_n;
	endclocking

	modport DRIVER (clocking driver_cb, input clk, rst_n);
	modport MONITOR (clocking monitor_cb, input clk, rst_n);

endinterface 
