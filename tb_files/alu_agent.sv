class alu_agent extends uvm_agent;
  `uvm_component_utils(alu_agent)
  
  alu_monitor am_h;
  alu_driver ad_h;
  uvm_sequencer # (alu_transaction) seqr;
  
  function new(string name="AGENT",uvm_component p);
    super.new(name,p);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      am_h = alu_monitor::type_id::create("am_h",this);
      ad_h = alu_driver::type_id::create("ad_h",this);
      seqr = uvm_sequencer # (alu_transaction)::type_id::create("seqr",this);
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      //SQR and DRV connection
    //DRv is initiator
      ad_h.seq_item_port.connect(seqr.seq_item_export);
    endfunction
    
endclass:alu_agent
