class dma_environment extends uvm_env;

  `uvm_component_utils(dma_environment)

  function new(string name = "dma_environment",uvm_component parent);
    super.new(name,parent);
  endfunction

  dma_agent agent;
  dma_scoreboard sb;
  dma_reg_block regmodel;
  dma_adapter adapter;
  uvm_reg_predictor #(dma_seq_item) predictor;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = dma_agent::type_id::create("agent",this);
    regmodel = dma_reg_block::type_id::create("regmodel", this);
    regmodel.build();
    adapter = dma_adapter::type_id::create("adapter",this);
    sb = dma_scoreboard::type_id::create("sb",this);
	predictor = uvm_reg_predictor#(dma_seq_item)::type_id::create("predictor", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.mon.mon_port.connect(sb.sb2mon);
    regmodel.default_map.set_sequencer( .sequencer(agent.seqr), .adapter(adapter) );
    regmodel.default_map.set_base_addr(0);
	predictor.map = regmodel.default_map;
	predictor.adapter = adapter;
	agent.mon.mon_port.connect(predictor.bus_in);

    regmodel.default_map.set_auto_predict(0);
  endfunction

endclass
