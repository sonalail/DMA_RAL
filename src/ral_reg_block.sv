`include "uvm_macros.svh"
import uvm_pkg::*;

class interrupt_reg extends uvm_reg;
	`uvm_object_utils(interrupt_reg)

	rand uvm_reg_field mask;
	rand uvm_reg_field status;

	covergroup intr_cp;
	option.per_instance = 1;
	coverpoint mask.value[31:16]
	{
		bins lower = {[0:15000]};
		bins mid   = {[15001:25000]};
		bins high  = {[25001:32767]};
	}

	coverpoint status.value[31:16]
	{
		bins lower = {[0:20000]};
		bins mid   = {[20001:40000]};
		bins high  = {[40001:65535]};
	}
	endgroup

	function new (string name = "interrupt_reg");
		super.new(name,32,UVM_CVR_FIELD_VALS); 
		if(has_coverage(UVM_CVR_FIELD_VALS))
		intr_cp = new();
	endfunction
	
	virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
		intr_cp.sample();
	endfunction
	
	virtual function void sample_values();
		super.sample_values();
		intr_cp.sample();
	endfunction

	function void build; 
		mask = uvm_reg_field::type_id::create("mask"); 
		mask.configure(.parent(this), 
							.size(16), 
							.lsb_pos(0), 
							.access("RO"), 
							.volatile(0), 
							.reset(16'h0), 
							.has_reset(1), 
							.is_rand(1), 
							.individually_accessible(1)); 

		status = uvm_reg_field::type_id::create("status"); 
		status.configure( .parent(this), 
							.size(16), 
							.lsb_pos(16), 
							.access("RW"), 
							.volatile(0), 
							.reset(16'h0), 
							.has_reset(1), 
							.is_rand(1), 
							.individually_accessible(1));

	endfunction

endclass

class dma_ctrl_reg extends uvm_reg;
	`uvm_object_utils(dma_ctrl_reg)

	rand uvm_reg_field start_dma;
	rand uvm_reg_field w_count;
	rand uvm_reg_field io_mem;
	
	covergroup dma_ctrl_cp;
	option.per_instance = 1;
	coverpoint start_dma.value[0];
	coverpoint w_count.value[15:1];
	coverpoint io_mem.value[16];
	endgroup

	function new (string name = "dma_ctrl_reg");
		super.new(name,32,UVM_CVR_FIELD_VALS);
		if(has_coverage(UVM_CVR_FIELD_VALS))
		dma_ctrl_cp = new(); 
	endfunction
	
	virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
		dma_ctrl_cp.sample();
	endfunction
	
	virtual function void sample_values();
		super.sample_values();
		dma_ctrl_cp.sample();
	endfunction

	function void build; 
		start_dma = uvm_reg_field::type_id::create("start_dma"); 
		start_dma.configure(.parent(this), 
							.size(1), 
							.lsb_pos(0), 
							.access("RW"), 
							.volatile(0), 
							.reset(1'h0), 
							.has_reset(1), 
							.is_rand(1), 
							.individually_accessible(1)); 

		w_count = uvm_reg_field::type_id::create("w_count"); 
		w_count.configure( .parent(this), 
							.size(15), 
							.lsb_pos(1), 
							.access("RW"), 
							.volatile(0), 
							.reset(15'h0), 
							.has_reset(1), 
							.is_rand(1), 
							.individually_accessible(1));

		io_mem = uvm_reg_field::type_id::create("io_mem"); 
		io_mem.configure( .parent(this), 
							.size(1), 
							.lsb_pos(16), 
							.access("RW"), 
							.volatile(0), 
							.reset(1'h0), 
							.has_reset(1), 
							.is_rand(1), 
							.individually_accessible(1));

	endfunction

endclass

class dma_io_reg extends uvm_reg;
	`uvm_object_utils(dma_io_reg)

	rand uvm_reg_field io_reg;

	covergroup dma_io_cp;
		option.per_instance = 1;
		coverpoint io_reg.value[31:0];
	endgroup
	
	function new (string name = "dma_io_reg");
		super.new(name,32,UVM_CVR_FIELD_VALS); 
		if(has_coverage(UVM_CVR_FIELD_VALS))
		dma_io_cp = new(); 
	endfunction
	
	virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
		dma_io_cp.sample();
	endfunction
	
	virtual function void sample_values();
		super.sample_values();
		dma_io_cp.sample();
	endfunction

	function void build; 
		io_reg = uvm_reg_field::type_id::create("io_reg"); 
		io_reg.configure(.parent(this), 
							.size(32), 
							.lsb_pos(0), 
							.access("RW"), 
							.volatile(0), 
							.reset(32'h0), 
							.has_reset(1), 
							.is_rand(1), 
							.individually_accessible(1)); 

	endfunction

endclass

class dma_mem_addr_reg extends uvm_reg;
  `uvm_object_utils(dma_mem_addr_reg)
  rand uvm_reg_field mem_addr;

  covergroup mem_addr_cp;
     option.per_instance = 1;
     coverpoint mem_addr.value[31:0];
  endgroup

  function new(string name = "dma_mem_addr_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS); 
	if(has_coverage(UVM_CVR_FIELD_VALS))
	mem_addr_cp = new(); 
  endfunction

  virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
	mem_addr_cp.sample();
  endfunction
	
  virtual function void sample_values();
	super.sample_values();
	mem_addr_cp.sample();
  endfunction

  virtual function void build();
    mem_addr = uvm_reg_field::type_id::create("mem_addr");
    mem_addr.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
  endfunction
endclass


class dma_extra_info_reg extends uvm_reg;
  `uvm_object_utils(dma_extra_info_reg)
  rand uvm_reg_field extra_info;
	
  covergroup dma_extra_info_cp;
     option.per_instance = 1;
     coverpoint extra_info.value[31:0];
  endgroup

  function new(string name = "dma_extra_info_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS); 
	if(has_coverage(UVM_CVR_FIELD_VALS))
	dma_extra_info_cp = new(); 
  endfunction

  virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
	dma_extra_info_cp.sample();
  endfunction
	
  virtual function void sample_values();
	super.sample_values();
	dma_extra_info_cp.sample();
  endfunction

  virtual function void build();
    extra_info = uvm_reg_field::type_id::create("extra_info");
    extra_info.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
  endfunction
endclass


class dma_status_reg extends uvm_reg;
  `uvm_object_utils(dma_status_reg)
  rand uvm_reg_field busy, done, error, paused, current_state, fifo_level;
  
  covergroup dma_status_cp;
     option.per_instance = 1;
     coverpoint busy.value[0];
     coverpoint done.value[1];
     coverpoint error.value[2];
     coverpoint paused.value[3];
     coverpoint current_state.value[7:4];
     coverpoint fifo_level.value[15:8];
  endgroup


  function new(string name = "dma_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS); 
	if(has_coverage(UVM_CVR_FIELD_VALS))
	dma_status_cp = new(); 
  endfunction

  virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
	dma_status_cp.sample();
  endfunction
	
  virtual function void sample_values();
	super.sample_values();
	dma_status_cp.sample();
  endfunction

  virtual function void build();
    busy          = uvm_reg_field::type_id::create("busy");
    done          = uvm_reg_field::type_id::create("done");
    error         = uvm_reg_field::type_id::create("error");
    paused        = uvm_reg_field::type_id::create("paused");
    current_state = uvm_reg_field::type_id::create("current_state");
    fifo_level    = uvm_reg_field::type_id::create("fifo_level");

    busy.configure(this, 1, 0, "RO", 1, 0, 1, 0, 1);
    done.configure(this, 1, 1, "RO", 1, 0, 1, 0, 1);
    error.configure(this, 1, 2, "RO", 1, 0, 1, 0, 1);
    paused.configure(this, 1, 3, "RO", 1, 0, 1, 0, 1);
    current_state.configure(this, 4, 4, "RO", 1, 0, 1, 0, 1);
    fifo_level.configure(this, 8, 8, "RO", 1, 0, 1, 0, 1);
  endfunction
endclass

class dma_transfer_count_reg extends uvm_reg;
  `uvm_object_utils(dma_transfer_count_reg)
  rand uvm_reg_field transfer_count;

  covergroup dma_transfer_count_cp;
     option.per_instance = 1;
     coverpoint transfer_count.value[31:0];
  endgroup

  function new(string name = "dma_transfer_count_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
	if(has_coverage(UVM_CVR_FIELD_VALS))
	dma_transfer_count_cp = new(); 
  endfunction

  virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
	dma_transfer_count_cp.sample();
  endfunction
	
  virtual function void sample_values();
	super.sample_values();
	dma_transfer_count_cp.sample();
  endfunction

  virtual function void build();
    transfer_count = uvm_reg_field::type_id::create("transfer_count");
    transfer_count.configure(this, 32, 0, "RO", 1, 32'h0, 1, 0, 1);
  endfunction
endclass

class dma_desc_addr_reg extends uvm_reg;
  `uvm_object_utils(dma_desc_addr_reg)
  rand uvm_reg_field descriptor_addr;

  covergroup dma_desc_addr_cp;
     option.per_instance = 1;
     coverpoint descriptor_addr.value[31:0];
  endgroup

  function new(string name = "dma_desc_addr_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
	if(has_coverage(UVM_CVR_FIELD_VALS))
	dma_desc_addr_cp = new(); 
  endfunction

  virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
	dma_desc_addr_cp.sample();
  endfunction
	
  virtual function void sample_values();
	super.sample_values();
	dma_desc_addr_cp.sample();
  endfunction

  virtual function void build();
    descriptor_addr = uvm_reg_field::type_id::create("descriptor_addr");
    descriptor_addr.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
  endfunction
endclass

class dma_error_status_reg extends uvm_reg;
  `uvm_object_utils(dma_error_status_reg)
  rand uvm_reg_field bus_error, timeout_error, alignment_error, overflow_error, underflow_error, error_code, error_addr_offset;

  covergroup dma_error_status_cp;
     option.per_instance = 1;
     coverpoint bus_error.value[0];
     coverpoint timeout_error.value[1];
     coverpoint alignment_error.value[2];
     coverpoint overflow_error.value[3];
     coverpoint underflow_error.value[4];
     coverpoint error_code.value[15:8];
     coverpoint error_addr_offset.value[31:16];
  endgroup

  function new(string name = "dma_error_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
	if(has_coverage(UVM_CVR_FIELD_VALS))
	dma_error_status_cp = new(); 
  endfunction

  virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
	dma_error_status_cp.sample();
  endfunction
	
  virtual function void sample_values();
	super.sample_values();
	dma_error_status_cp.sample();
  endfunction

  virtual function void build();
    bus_error         = uvm_reg_field::type_id::create("bus_error");
    timeout_error     = uvm_reg_field::type_id::create("timeout_error");
    alignment_error   = uvm_reg_field::type_id::create("alignment_error");
    overflow_error    = uvm_reg_field::type_id::create("overflow_error");
    underflow_error   = uvm_reg_field::type_id::create("underflow_error");
    error_code        = uvm_reg_field::type_id::create("error_code");
    error_addr_offset = uvm_reg_field::type_id::create("error_addr_offset");

    bus_error.configure(this, 1, 0, "W1C", 0, 0, 1, 1, 1);
    timeout_error.configure(this, 1, 1, "W1C", 0, 0, 1, 1, 1);
    alignment_error.configure(this, 1, 2, "W1C", 0, 0, 1, 1, 1);
    overflow_error.configure(this, 1, 3, "W1C", 0, 0, 1, 1, 1);
    underflow_error.configure(this, 1, 4, "W1C", 0, 0, 1, 1, 1);
    error_code.configure(this, 8, 8, "RO", 1, 0, 1, 0, 1);
    error_addr_offset.configure(this, 16, 16, "RO", 1, 0, 1, 0, 1);
  endfunction
endclass

class dma_config_reg extends uvm_reg;
  `uvm_object_utils(dma_config_reg)
  rand uvm_reg_field priority_lvl, auto_restart, interrupt_enable, burst_size, data_width, descriptor_mode;
 
  covergroup dma_config_cp;
     option.per_instance = 1;
     coverpoint priority_lvl.value[1:0];
     coverpoint auto_restart.value[2];
     coverpoint interrupt_enable.value[3];
     coverpoint burst_size.value[5:4];
     coverpoint data_width.value[7:6];
     coverpoint descriptor_mode.value[8];
  endgroup

  function new(string name = "dma_config_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
	dma_config_cp = new(); 
  endfunction

  virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
	dma_config_cp.sample();
  endfunction
	
  virtual function void sample_values();
	super.sample_values();
	dma_config_cp.sample();
  endfunction

  virtual function void build();
    priority_lvl     = uvm_reg_field::type_id::create("priority_lvl");
    auto_restart     = uvm_reg_field::type_id::create("auto_restart");
    interrupt_enable = uvm_reg_field::type_id::create("interrupt_enable");
    burst_size       = uvm_reg_field::type_id::create("burst_size");
    data_width       = uvm_reg_field::type_id::create("data_width");
    descriptor_mode  = uvm_reg_field::type_id::create("descriptor_mode");

    priority_lvl.configure(this, 2, 0, "RW", 0, 2'h0, 1, 1, 1);
    auto_restart.configure(this, 1, 2, "RW", 0, 1'h0, 1, 1, 1);
    interrupt_enable.configure(this, 1, 3, "RW", 0, 1'h0, 1, 1, 1);
    burst_size.configure(this, 2, 4, "RW", 0, 2'h0, 1, 1, 1);
    data_width.configure(this, 2, 6, "RW", 0, 2'h0, 1, 1, 1);
    descriptor_mode.configure(this, 1, 8, "RW", 0, 1'h0, 1, 1, 1);
  endfunction
endclass


//reg block

class dma_reg_block extends uvm_reg_block;
	`uvm_object_utils(dma_reg_block)
	rand interrupt_reg reg_inst; 
	rand dma_io_reg io_reg_inst;
	rand dma_ctrl_reg           ctrl_reg_inst;
  	rand dma_mem_addr_reg       mem_addr_reg_inst;
  	rand dma_extra_info_reg     extra_info_reg_inst;
  	rand dma_status_reg         status_reg_inst;
  	rand dma_transfer_count_reg transfer_count_reg_inst;
  	rand dma_desc_addr_reg      desc_addr_reg_inst;
  	rand dma_error_status_reg   error_status_reg_inst;
  	rand dma_config_reg         config_reg_inst;

	function new (string name = "dma_reg_block");
		super.new(name, build_coverage(UVM_NO_COVERAGE));
	endfunction

	function void build;
	uvm_reg::include_coverage("*", UVM_CVR_ALL);

		add_hdl_path("dma_top.dut","RTL");
		reg_inst = interrupt_reg::type_id::create("reg_inst");
		reg_inst.build();
		reg_inst.configure(this);
		reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
	
		ctrl_reg_inst = dma_ctrl_reg::type_id::create("ctrl_reg_inst");
    		ctrl_reg_inst.build();
    		ctrl_reg_inst.configure(this);
		ctrl_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
	
		io_reg_inst = dma_io_reg::type_id::create("io_reg_inst");
    	io_reg_inst.build();
    	io_reg_inst.configure(this);
	io_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);

    	mem_addr_reg_inst = dma_mem_addr_reg::type_id::create("mem_addr_reg_inst");
    	mem_addr_reg_inst.build();
    	mem_addr_reg_inst.configure(this);
	mem_addr_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);

    	extra_info_reg_inst = dma_extra_info_reg::type_id::create("extra_info_reg_inst");
   		extra_info_reg_inst.build();
    	extra_info_reg_inst.configure(this);
	extra_info_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
    	extra_info_reg_inst.add_hdl_path_slice("extra_info",0,32);


    	status_reg_inst = dma_status_reg::type_id::create("status_reg_inst");
    	status_reg_inst.build();
    	status_reg_inst.configure(this);
	status_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);

    	status_reg_inst.add_hdl_path_slice("status_busy",0,1);
    	status_reg_inst.add_hdl_path_slice("status_done",1,1);
    	status_reg_inst.add_hdl_path_slice("status_error",2,1);
    	status_reg_inst.add_hdl_path_slice("status_paused",3,1);
    	status_reg_inst.add_hdl_path_slice("status_current_state",4,4);
    	status_reg_inst.add_hdl_path_slice("status_fifo_level",8,8);

    	transfer_count_reg_inst = dma_transfer_count_reg::type_id::create("transfer_count_reg_inst");
    	transfer_count_reg_inst.build();
    	transfer_count_reg_inst.configure(this);
	transfer_count_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
    	transfer_count_reg_inst.add_hdl_path_slice("transfer_count",0,32);
    	
		desc_addr_reg_inst = dma_desc_addr_reg::type_id::create("desc_addr_reg_inst");
    	desc_addr_reg_inst.build();
    	desc_addr_reg_inst.configure(this);
	desc_addr_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);

    	error_status_reg_inst = dma_error_status_reg::type_id::create("error_status_reg_inst");
    	error_status_reg_inst.build();
    	error_status_reg_inst.configure(this);
	error_status_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);

    	config_reg_inst = dma_config_reg::type_id::create("config_reg_inst");
    	config_reg_inst.build();
    	config_reg_inst.configure(this);
	config_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);

	default_map = create_map("default_map", 'h0, 4, UVM_LITTLE_ENDIAN);
	default_map.add_reg(reg_inst , 'h400, "RW"); 
	default_map.add_reg(ctrl_reg_inst,           'h404, "RW");
	default_map.add_reg(io_reg_inst,             'h408, "RW");
    	default_map.add_reg(mem_addr_reg_inst,       'h40C, "RW");
    	default_map.add_reg(extra_info_reg_inst,     'h410, "RW");
    	default_map.add_reg(status_reg_inst,         'h414, "RO");
    	default_map.add_reg(transfer_count_reg_inst, 'h418, "RO");
    	default_map.add_reg(desc_addr_reg_inst,      'h41C, "RW");
    	default_map.add_reg(error_status_reg_inst,   'h420, "RW");
    	default_map.add_reg(config_reg_inst,         'h424, "RW");	 
	
	default_map.set_auto_predict(0);
	
	lock_model();

	endfunction
endclass


module tb;
  dma_reg_block t1;
  initial begin
    t1 = new("dma_reg_block");
    t1.build();
  end
endmodule
