class dma_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(dma_scoreboard)

	uvm_analysis_imp#(dma_seq_item,dma_scoreboard) sb2mon;
	dma_seq_item packet[$];

	function new(string name = "dma_scoreboard", uvm_component parent = null);
	  super.new(name, parent);
    endfunction

	virtual function void  build_phase(uvm_phase phase);
	   super.build_phase(phase);
	   sb2mon=new("sb2mon",this);
	endfunction
					    
	virtual function void write(dma_seq_item item);
	  packet.push_back(item);
	endfunction

	virtual task run_phase(uvm_phase phase);

	endtask

endclass
