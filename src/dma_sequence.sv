class dma_sequence extends uvm_sequence #(dma_seq_item);
	`uvm_object_utils(dma_sequence)

	dma_reg_block regblock;
	
	function new(string name = "dma_sequence");
		super.new(name);
	endfunction 

	task body();
	endtask 

endclass


class Interrupt_seq extends dma_sequence;
	`uvm_object_utils(Interrupt_seq)

	function new(string name = "Interrupt_seq");
		super.new(name);
	endfunction 

	task body();
		uvm_status_e status; 
		bit [31:0] w_data ,r_data, mirror_value;
		w_data = 32'hFFFF_0000; 

		`uvm_info(get_type_name(), $sformatf("Data to be written is = %h ", w_data), UVM_MEDIUM)
		regblock.reg_inst.write(status, w_data, UVM_FRONTDOOR);
		regblock.reg_inst.sample_values();
		regblock.reg_inst.read(status, r_data, UVM_FRONTDOOR);

		`uvm_info(get_type_name(), $sformatf("value read from the dut is  = %h ", r_data), UVM_MEDIUM)
	endtask

endclass



class Control_seq extends dma_sequence;
	`uvm_object_utils(Control_seq)

	function new(string name = "Control_seq");
		super.new(name);
	endfunction 

	task body();
		uvm_status_e status; 
		bit [31:0] w_data ;
		bit [31:0] rdata, mirror_value;
		w_data = 32'h0000_ABCD; 

		`uvm_info(get_type_name(), $sformatf("Data to be written is = %h ", w_data), UVM_MEDIUM)
		regblock.ctrl_reg_inst.write(status, w_data);
		regblock.ctrl_reg_inst.read(status, rdata, UVM_FRONTDOOR);
		`uvm_info(get_type_name(),$sformatf("value read from the dut is  = %h", rdata), UVM_MEDIUM)
	endtask
endclass

class Io_addr_seq extends dma_sequence;
	`uvm_object_utils(Io_addr_seq)

	function new(string name = "Io_addr_seq");
		super.new(name);
	endfunction 

	task body();
		uvm_status_e status; 
		bit [31:0] w_data ,r_data, mirror_value;
		w_data = 32'hB0B0_A5A5; 

		`uvm_info(get_type_name(), $sformatf("Data to be written is = %h ", w_data), UVM_MEDIUM)
		regblock.io_reg_inst.write(status, w_data, UVM_FRONTDOOR);

		regblock.io_reg_inst.read(status, r_data, UVM_FRONTDOOR);

		`uvm_info(get_type_name(), $sformatf("value read from the dut is  = %h ", r_data), UVM_MEDIUM)
	endtask
endclass


class Mem_addr_seq extends dma_sequence;
	`uvm_object_utils(Mem_addr_seq)

	function new(string name = "Mem_addr_seq");
		super.new(name);
	endfunction 

	task body();
		uvm_status_e status; 
		bit [31:0] w_data ,r_data, mirror_value;
		w_data = 32'hC1C1_A5A5; 

		`uvm_info(get_type_name(), $sformatf("Data to be written is = %h ", w_data), UVM_MEDIUM)
		regblock.mem_addr_reg_inst.write(status, w_data, UVM_FRONTDOOR);

		regblock.mem_addr_reg_inst.read(status, r_data, UVM_FRONTDOOR);

		`uvm_info(get_type_name(), $sformatf("value read from the dut is  = %h ", r_data), UVM_MEDIUM)
	endtask
endclass


class Extra_info_seq extends dma_sequence;
	`uvm_object_utils(Extra_info_seq)

	function new(string name = "Extra_info_seq");
		super.new(name);
	endfunction 

	task body();
		uvm_status_e status; 
		bit [31:0] w_data ,r_data, mirror_value;
		w_data = 32'hB0B0_A5A5; 

		`uvm_info(get_type_name(), $sformatf("Data to be written is = %h ", w_data), UVM_MEDIUM)
		regblock.extra_info_reg_inst.write(status, w_data, UVM_FRONTDOOR);

		regblock.extra_info_reg_inst.read(status, r_data, UVM_FRONTDOOR);

		`uvm_info(get_type_name(), $sformatf("value read from the dut is  = %h ", r_data), UVM_MEDIUM)
	endtask
endclass


class Status_seq extends dma_sequence;
	`uvm_object_utils(Status_seq)

	function new(string name = "Status_seq");
		super.new(name);
	endfunction 

	task body();
		uvm_status_e status; 
		bit [31:0] w_data ,r_data, mirror_value;

		regblock.status_reg_inst.read(status, r_data, UVM_FRONTDOOR);

		`uvm_info(get_type_name(), $sformatf("value read from the dut is  = %h ", r_data), UVM_MEDIUM)
	endtask
endclass


class Transfer_count_seq extends dma_sequence;
	`uvm_object_utils(Transfer_count_seq)

	function new(string name = "Transfer_count_seq");
		super.new(name);
	endfunction 

	task body();
		uvm_status_e status; 
		bit [31:0] w_data ,r_data, mirror_value;

		regblock.transfer_count_reg_inst.read(status, r_data, UVM_FRONTDOOR);

		`uvm_info(get_type_name(), $sformatf("value read from the dut is  = %h ", r_data), UVM_MEDIUM)
	endtask
endclass

class Descriptor_addr_seq extends dma_sequence;
	`uvm_object_utils(Descriptor_addr_seq)

	function new(string name = "Descriptor_addr_seq");
		super.new(name);
	endfunction 

	task body();
		uvm_status_e status; 
		bit [31:0] w_data ,r_data, mirror_value;
		w_data = 32'hB0B0_A5A5; 

		`uvm_info(get_type_name(), $sformatf("Data to be written is = %h ", w_data), UVM_MEDIUM)
		regblock.desc_addr_reg_inst.write(status, w_data, UVM_FRONTDOOR);

		regblock.desc_addr_reg_inst.read(status, r_data, UVM_FRONTDOOR);

		`uvm_info(get_type_name(), $sformatf("value read from the dut is  = %h ", r_data), UVM_MEDIUM)
	endtask
endclass


class Config_seq extends dma_sequence;
	`uvm_object_utils(Config_seq)

	function new(string name = "Config_seq");
		super.new(name);
	endfunction 

	task body();
		uvm_status_e status; 
		bit [31:0] w_data ,r_data, mirror_value;
		w_data = 32'h0000_00A5; 

		`uvm_info(get_type_name(), $sformatf("Data to be written is = %h ", w_data), UVM_MEDIUM)
		regblock.config_reg_inst.write(status, w_data, UVM_FRONTDOOR);

		regblock.config_reg_inst.read(status, r_data, UVM_FRONTDOOR);

		`uvm_info(get_type_name(), $sformatf("value read from the dut is  = %h ", r_data), UVM_MEDIUM)
	endtask
endclass


class all_reg_reset_seq extends dma_sequence;
	`uvm_object_utils(all_reg_reset_seq)


	function new(string name = "all_reg_reset_seq");
		super.new(name);
	endfunction 

	task body();
		uvm_status_e status; 
		bit [31:0] w_data ,r_data, mirror_value;

		regblock.reg_inst.reset();
		regblock.reg_inst.read(status, r_data, UVM_FRONTDOOR);
		`uvm_info(get_type_name(), $sformatf("value read from the dut after reset of interrupt register is  = %h ", r_data), UVM_MEDIUM)


		regblock.io_reg_inst.reset();
		regblock.io_reg_inst.read(status, r_data, UVM_FRONTDOOR);
		`uvm_info(get_type_name(), $sformatf("value read from the dut after reset from io_reg is = %h ", r_data), UVM_MEDIUM)


		regblock.ctrl_reg_inst.reset();
		regblock.ctrl_reg_inst.read(status, r_data, UVM_FRONTDOOR);
		`uvm_info(get_type_name(), $sformatf("value read from the dut after reset from ctrl reg is  = %h ", r_data), UVM_MEDIUM)


		regblock.mem_addr_reg_inst.reset();
		regblock.mem_addr_reg_inst.read(status, r_data, UVM_FRONTDOOR);
		`uvm_info(get_type_name(), $sformatf("value read from the dut after reset from mem addr reg is  = %h ", r_data), UVM_MEDIUM)


		regblock.extra_info_reg_inst.reset();
		regblock.extra_info_reg_inst.read(status, r_data, UVM_FRONTDOOR);
		`uvm_info(get_type_name(), $sformatf("value read from the dut after reset from extra info reg is  = %h ", r_data), UVM_MEDIUM)


		regblock.status_reg_inst.reset();
		regblock.status_reg_inst.read(status, r_data, UVM_FRONTDOOR);
		`uvm_info(get_type_name(), $sformatf("value read from the dut after reset from status reg is  = %h ", r_data), UVM_MEDIUM)


		regblock.transfer_count_reg_inst.reset();
		regblock.transfer_count_reg_inst.read(status, r_data, UVM_FRONTDOOR);
		`uvm_info(get_type_name(), $sformatf("value read from the dut after reset from transfer count reg is  = %h ", r_data), UVM_MEDIUM)


		regblock.desc_addr_reg_inst.reset();
		regblock.desc_addr_reg_inst.read(status, r_data, UVM_FRONTDOOR);
		`uvm_info(get_type_name(), $sformatf("value read from the dut after reset from description address reg is  = %h ", r_data), UVM_MEDIUM)


		regblock.error_status_reg_inst.reset();
		regblock.error_status_reg_inst.read(status, r_data, UVM_FRONTDOOR);
		`uvm_info(get_type_name(), $sformatf("value read from the dut after reset from error status reg is  = %h ", r_data), UVM_MEDIUM)


		regblock.config_reg_inst.reset();
		regblock.config_reg_inst.read(status, r_data, UVM_FRONTDOOR);
		`uvm_info(get_type_name(), $sformatf("value read from the dut after reset from config reg is  = %h ", r_data), UVM_MEDIUM)
	endtask

endclass


