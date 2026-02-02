`include "uvm_macros.svh"
import uvm_pkg::*;

class interrupt_reg extends uvm_reg;
	`uvm_object_utils(interrupt_reg)

	rand uvm_reg_field mask;
	rand uvm_reg_field status;

	function new (string name = "interrupt_reg");
		super.new(name,32,UVM_NO_COVERAGE); 
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

	function new (string name = "dma_ctrl_reg");
		super.new(name,32,UVM_NO_COVERAGE); 
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

	function new (string name = "dma_io_reg");
		super.new(name,32,UVM_NO_COVERAGE); 
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

  function new(string name = "dma_mem_addr_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    mem_addr = uvm_reg_field::type_id::create("mem_addr");
    mem_addr.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
  endfunction
endclass

class dma_extra_info_reg extends uvm_reg;
  `uvm_object_utils(dma_extra_info_reg)
  rand uvm_reg_field extra_info;

  function new(string name = "dma_extra_info_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    extra_info = uvm_reg_field::type_id::create("extra_info");
    extra_info.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
  endfunction
endclass

class dma_status_reg extends uvm_reg;
  `uvm_object_utils(dma_status_reg)
  rand uvm_reg_field busy, done, error, paused, current_state, fifo_level;

  function new(string name = "dma_status_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
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

  function new(string name = "dma_transfer_count_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    transfer_count = uvm_reg_field::type_id::create("transfer_count");
    transfer_count.configure(this, 32, 0, "RO", 1, 32'h0, 1, 0, 1);
  endfunction
endclass

class dma_desc_addr_reg extends uvm_reg;
  `uvm_object_utils(dma_desc_addr_reg)
  rand uvm_reg_field descriptor_addr;

  function new(string name = "dma_desc_addr_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    descriptor_addr = uvm_reg_field::type_id::create("descriptor_addr");
    descriptor_addr.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
  endfunction
endclass

class dma_error_status_reg extends uvm_reg;
  `uvm_object_utils(dma_error_status_reg)
  rand uvm_reg_field bus_error, timeout_error, alignment_error, overflow_error, underflow_error, error_code, error_addr_offset;

  function new(string name = "dma_error_status_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
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

  function new(string name = "dma_config_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
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
		add_hdl_path("dma_top.dut","RTL");
		reg_inst = interrupt_reg::type_id::create("reg_inst");
		reg_inst.build();
		reg_inst.configure(this);
	
		ctrl_reg_inst = dma_ctrl_reg::type_id::create("ctrl_reg_inst");
    	ctrl_reg_inst.build();
    	ctrl_reg_inst.configure(this);
	
		io_reg_inst = dma_io_reg::type_id::create("io_reg_inst");
    	io_reg_inst.build();
    	io_reg_inst.configure(this);

    	mem_addr_reg_inst = dma_mem_addr_reg::type_id::create("mem_addr_reg_inst");
    	mem_addr_reg_inst.build();
    	mem_addr_reg_inst.configure(this);

    	extra_info_reg_inst = dma_extra_info_reg::type_id::create("extra_info_reg_inst");
   		extra_info_reg_inst.build();
    	extra_info_reg_inst.configure(this);
    	extra_info_reg_inst.add_hdl_path_slice("extra_info",0,32);


    	status_reg_inst = dma_status_reg::type_id::create("status_reg_inst");
    	status_reg_inst.build();
    	status_reg_inst.configure(this);

    	transfer_count_reg_inst = dma_transfer_count_reg::type_id::create("transfer_count_reg_inst");
    	transfer_count_reg_inst.build();
    	transfer_count_reg_inst.configure(this);

    	desc_addr_reg_inst = dma_desc_addr_reg::type_id::create("desc_addr_reg_inst");
    	desc_addr_reg_inst.build();
    	desc_addr_reg_inst.configure(this);

    	error_status_reg_inst = dma_error_status_reg::type_id::create("error_status_reg_inst");
    	error_status_reg_inst.build();
    	error_status_reg_inst.configure(this);

    	config_reg_inst = dma_config_reg::type_id::create("config_reg_inst");
    	config_reg_inst.build();
    	config_reg_inst.configure(this);

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
