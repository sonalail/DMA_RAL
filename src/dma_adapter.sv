class dma_adapter extends uvm_reg_adapter;
  `uvm_object_utils(dma_adapter)
  
  function new(string name = "dma_adapter");
    super.new(name);
  endfunction
  
  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    dma_seq_item item;
    item = dma_seq_item::type_id::create("item");
    item.wr_en = (rw.kind == UVM_WRITE);
    item.rd_en = (rw.kind == UVM_READ);
    item.addr = rw.addr;
    item.wdata = rw.data;
    return item;
  endfunction
  
  function void bus2reg(uvm_sequence_item bus_item,ref uvm_reg_bus_op rw);
    dma_seq_item item;
    assert ($cast(item,bus_item));
    rw.addr = item.addr;
    rw.status = UVM_IS_OK;
    if(item.rd_en)
	begin
		rw.data = item.rdata;
		rw.kind = UVM_READ;
	end

    else
	begin
		rw.data = item.wdata;
		rw.kind = UVM_WRITE;
	end
    
  endfunction
endclass
