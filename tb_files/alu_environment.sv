class alu_env extends uvm_env;
  `uvm_component_utils(alu_env)
  alu_scoreboard as_h;
  alu_agent alu_agnt_h;
  alu_coverage alu_cov_h;
  
  function new(string name="ENV",uvm_component p);
    super.new(name,p);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    as_h = alu_scoreboard::type_id::create("as_h",this);
    alu_agnt_h = alu_agent::type_id::create("alu_agent_h",this);
   alu_cov_h = alu_coverage::type_id::create("alu_cov_h",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //analysis port connection
    //Agent is the initiator
    alu_agnt_h.am_h.alu_ap.connect(as_h.alu_ap_imp);
    alu_agnt_h.am_h.alu_ap.connect(alu_cov_h.alu_cov_ap_imp);
  endfunction
  
endclass:alu_env
