class dma_test extends uvm_test;

	dma_environment env;

	`uvm_component_utils(dma_test)

	function new(string name = "dma_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = dma_environment::type_id::create("env", this);
	endfunction 

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		`uvm_info(get_type_name(), $sformatf("Inside DMA_TEST"), UVM_LOW);
  		`uvm_info(get_type_name(), $sformatf("Done DMA_TEST"), UVM_LOW);	
		phase.drop_objection(this);
	endtask

endclass

 
class all_reg_reset_test extends dma_test;

	`uvm_component_utils(all_reg_reset_test)

	all_reg_reset_seq seq1;

	function new(string name = "all_reg_reset_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq1 = all_reg_reset_seq::type_id::create("seq1", this);
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	    seq1.regblock = env.regmodel;
        seq1.start(env.agent.seqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this, 20);

	endtask

endclass

class Interrupt_test extends dma_test;

	`uvm_component_utils(Interrupt_test)

	Interrupt_seq seq2;

	function new(string name = "Interrupt_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq2 = Interrupt_seq::type_id::create("seq2", this);
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	    seq2.regblock = env.regmodel;
        seq2.start(env.agent.seqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this, 20);

	endtask

endclass

class Control_test extends dma_test;

	`uvm_component_utils(Control_test)

	Control_seq seq4;

	function new(string name = "Control_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq4 = Control_seq::type_id::create("seq4", this);
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	    seq4.regblock = env.regmodel;
        seq4.start(env.agent.seqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this, 50);

	endtask

endclass


class Io_addr_test extends dma_test;

	`uvm_component_utils(Io_addr_test)

	Io_addr_seq seq5;

	function new(string name = "Io_addr_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq5 = Io_addr_seq::type_id::create("seq5", this);
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	    seq5.regblock = env.regmodel;
        seq5.start(env.agent.seqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this, 20);

	endtask
endclass


class Mem_addr_test extends dma_test;

	`uvm_component_utils(Mem_addr_test)

	Mem_addr_seq seq6;

	function new(string name = "Mem_addr_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq6 = Mem_addr_seq::type_id::create("seq6", this);
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	    seq6.regblock = env.regmodel;
        seq6.start(env.agent.seqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this, 20);

	endtask
endclass

class Extra_info_test extends dma_test;

	`uvm_component_utils(Extra_info_test)

	Extra_info_seq seq7;

	function new(string name = "Extra_info_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq7 = Extra_info_seq::type_id::create("seq7", this);
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	    seq7.regblock = env.regmodel;
        seq7.start(env.agent.seqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this, 20);

	endtask
endclass

class Status_test extends dma_test;

	`uvm_component_utils(Status_test)

	Status_seq seq8;

	function new(string name = "Status_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq8 = Status_seq::type_id::create("seq8", this);
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	    seq8.regblock = env.regmodel;
        seq8.start(env.agent.seqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this, 20);
	endtask
endclass


class Transfer_count_test extends dma_test;

	`uvm_component_utils(Transfer_count_test)

	Transfer_count_seq seq9;

	function new(string name = "Transfer_count_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq9 = Transfer_count_seq::type_id::create("seq9", this);
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	    seq9.regblock = env.regmodel;
        seq9.start(env.agent.seqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this, 20);
	endtask
endclass

class Descriptor_addr_test extends dma_test;

	`uvm_component_utils(Descriptor_addr_test)

	Descriptor_addr_seq seq10;

	function new(string name = "Descriptor_addr_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq10 = Descriptor_addr_seq::type_id::create("seq10", this);
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	    seq10.regblock = env.regmodel;
        seq10.start(env.agent.seqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this, 20);
	endtask
endclass


class Config_test extends dma_test;

	`uvm_component_utils(Config_test)

	Config_seq seq11;

	function new(string name = "Config_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq11 = Config_seq::type_id::create("seq11", this);
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	    seq11.regblock = env.regmodel;
        seq11.start(env.agent.seqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this, 20);
	endtask

endclass

class Write_status_test extends dma_test;

	`uvm_component_utils(Write_status_test)

	Write_status_seq seq12;

	function new(string name = "Write_status_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq12 = Write_status_seq::type_id::create("seq12", this);
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	    seq12.regblock = env.regmodel;
        seq12.start(env.agent.seqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this, 20);
	endtask

endclass


class Reset_method_test extends dma_test;

	`uvm_component_utils(Reset_method_test)

	reset_method_seq seq13;

	function new(string name = "Reset_method_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq13 = reset_method_seq::type_id::create("seq13", this);
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	    seq13.regblock = env.regmodel;
        seq13.start(env.agent.seqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this, 20);
	endtask
endclass
