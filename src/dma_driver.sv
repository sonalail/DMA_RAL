class dma_driver extends uvm_driver #(dma_seq_item);

	virtual dma_intf.DRIVER vif;
	dma_seq_item req;

	`uvm_component_utils(dma_driver)

	function new(string name = "dma_driver", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual dma_intf.DRIVER)::get(this, "", "vif", vif))
			`uvm_fatal(get_type_name(), "Unable to obtain config at driver")
			req = dma_seq_item::type_id::create("packet",this);
	endfunction

	virtual task run_phase(uvm_phase phase);
		forever
		begin
			seq_item_port.get_next_item(req);
			drive();
			seq_item_port.item_done();
		end
	endtask 	

	virtual task drive();
		 @(vif.driver_cb);
		$display("driving at ",$time);
		vif.driver_cb.wr_en <= req.wr_en;
		vif.driver_cb.rd_en <= req.rd_en;
		vif.driver_cb.addr  <= req.addr;
		if(req.wr_en)
		vif.driver_cb.wdata <= req.wdata;
		@(vif.driver_cb);
		if(req.rd_en)
		begin
		$display("rdata in driver = %0d",vif.driver_cb.rdata,$time);
		req.rdata = vif.driver_cb.rdata;
		end
		@(vif.driver_cb);
	endtask

endclass 
