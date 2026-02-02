class dma_monitor extends uvm_monitor;

	virtual dma_intf.MONITOR vif;
	dma_seq_item packet;
	uvm_analysis_port #(dma_seq_item) mon_port;

	`uvm_component_utils(dma_monitor)

	function new(string name = "dma_monitor", uvm_component parent = null);
		super.new(name, parent);
		mon_port = new("mon_port", this);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual dma_intf.MONITOR)::get(this, "", "vif", vif))
			`uvm_fatal(get_type_name(), "Config not set at top")

	endfunction 

	virtual task run_phase(uvm_phase phase);
		forever
		begin
		packet = dma_seq_item ::type_id ::create("packet",this);
			repeat(3) @(vif.monitor_cb);
			packet.wr_en = vif.monitor_cb.wr_en;
			packet.rd_en = vif.monitor_cb.rd_en;
			packet.wdata = vif.monitor_cb.wdata;
			packet.addr  = vif.monitor_cb.addr;
			packet.rdata = vif.monitor_cb.rdata;
			//repeat(1) @(vif.monitor_cb);
			mon_port.write(packet);	
			
		end
	endtask 
endclass 
