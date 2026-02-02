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
		bit [31:0] w_data ,rdata, mirror_value;
		w_data = 32'hB0B0_A5A5; 
		
		//write read method
		`uvm_info(get_type_name(), $sformatf("Data to be written is = %h ", w_data), UVM_MEDIUM)
		regblock.io_reg_inst.write(status, w_data, UVM_FRONTDOOR);

		regblock.io_reg_inst.read(status, rdata, UVM_FRONTDOOR);

		`uvm_info(get_type_name(), $sformatf("value read from the dut is  = %h ", rdata), UVM_MEDIUM)
		
		//set get method
		rdata = regblock.io_reg_inst.get();
		`uvm_info(get_type_name(), $sformatf("Desired value before setting is = %h ", rdata), UVM_MEDIUM)
		
		regblock.io_reg_inst.set(32'h1010_1010);

		rdata = regblock.io_reg_inst.get();
		`uvm_info(get_type_name(), $sformatf("Desired value after setting is = %h ", rdata), UVM_MEDIUM)

		//mirror value set get method
		rdata = regblock.io_reg_inst.get();
		mirror_value = regblock.io_reg_inst.get_mirrored_value();
		`uvm_info(get_type_name(), $sformatf("Desired value = %0h and mirrored value = %0h before setting ", rdata,mirror_value), UVM_MEDIUM)
		
		regblock.io_reg_inst.set(32'hA5A5_A5A5);

		rdata = regblock.io_reg_inst.get();
		mirror_value = regblock.io_reg_inst.get_mirrored_value();
		`uvm_info(get_type_name(), $sformatf("Desired value = %0h and mirrored value = %0h after setting ", rdata,mirror_value), UVM_MEDIUM)

		regblock.io_reg_inst.update(status);

		rdata = regblock.io_reg_inst.get();
		mirror_value = regblock.io_reg_inst.get_mirrored_value();
		`uvm_info(get_type_name(), $sformatf("Desired value = %0h and mirrored value = %0h after update method ", rdata,mirror_value), UVM_MEDIUM)
		//mirror value predict method with write method
		regblock.io_reg_inst.write(status,32'h1111_1111);
		rdata = regblock.io_reg_inst.get();
		mirror_value = regblock.io_reg_inst.get_mirrored_value();
		`uvm_info(get_type_name(), $sformatf("Desired value = %0h and mirrored value = %0h before predict ", rdata,mirror_value), UVM_MEDIUM)
		
		regblock.io_reg_inst.predict(32'hBBBB_BBBB);

		rdata = regblock.io_reg_inst.get();
		mirror_value = regblock.io_reg_inst.get_mirrored_value();
		`uvm_info(get_type_name(), $sformatf("Desired value = %0h and mirrored value = %0h after predict method ", rdata,mirror_value), UVM_MEDIUM)

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


class Write_status_seq extends dma_sequence;
	`uvm_object_utils(Write_status_seq)

	function new(string name = "Write_status_seq");
		super.new(name);
	endfunction 

	task body();
		uvm_status_e status; 
		bit [31:0] w_data ,r_data, mirror_value;
		w_data = 32'h0000_00A5; 

		`uvm_info(get_type_name(), $sformatf("Data to be written is = %h ", w_data), UVM_MEDIUM)
		regblock.config_reg_inst.write(status, w_data, UVM_FRONTDOOR);
		if(status != UVM_IS_OK)
		`uvm_error(get_type_name(),"Attempting to write to a read only register");
		//regblock.config_reg_inst.read(status, r_data, UVM_FRONTDOOR);

		`uvm_info(get_type_name(), $sformatf("value read from the dut is  = %h ", r_data), UVM_MEDIUM)
	endtask
endclass

class reset_method_seq extends dma_sequence;
	`uvm_object_utils(reset_method_seq)

	function new(string name = "reset_method_seq");
		super.new(name);
	endfunction 

	task body();
		uvm_status_e status; 
		bit [31:0] rst_reg ,rdata, mirror_value;
		bit rst_status;
		
		rst_status = regblock.mem_addr_reg_inst.has_reset();
		`uvm_info(get_type_name(), $sformatf("Reset status is %h",rst_status), UVM_MEDIUM)
		rst_reg = regblock.mem_addr_reg_inst.get_reset();
		`uvm_info(get_type_name(), $sformatf("Reset value is %h",rst_reg), UVM_MEDIUM)
		
		rdata = regblock.mem_addr_reg_inst.get();
		mirror_value = regblock.mem_addr_reg_inst.get_mirrored_value();
		`uvm_info("SEQ", $sformatf("Before Reset -> Mir : %0d Des : %0d ", mirror_value, rdata), UVM_NONE);
		///////////////mir and des value after rst
		$display("--------------Applying Reset to register model ---------------");
		regblock.mem_addr_reg_inst.reset();
		rdata = regblock.mem_addr_reg_inst.get();
		mirror_value = regblock.mem_addr_reg_inst.get_mirrored_value();
		`uvm_info("SEQ", $sformatf("After Reset -> Mir : %0d Des : %0d ", mirror_value, rdata), UVM_NONE);
		/////////////updating rst value
		$display("--------------Updating register reset value and applying Reset ---------------");
		regblock.mem_addr_reg_inst.set_reset(32'hff);
		regblock.mem_addr_reg_inst.reset();
		rdata = regblock.mem_addr_reg_inst.get();
		mirror_value = regblock.mem_addr_reg_inst.get_mirrored_value();
		`uvm_info("SEQ", $sformatf("After Reset -> Mir : %0d Des : %0d ", mirror_value, rdata), UVM_NONE);
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


