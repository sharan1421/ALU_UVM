class alu_test extends uvm_test;
  `uvm_component_utils(alu_test)
  alu_env ae_h;
  alu_generator agen_h;//Sequence
  
  alu_gen_directed_test alu_direct_test_h;
  
  function new(string name="TEST", uvm_component p);
    super.new(name,p);
    endfunction
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ae_h = alu_env::type_id::create("ae_h",this);
    agen_h = alu_generator::type_id::create("agen_h",this);
    alu_direct_test_h=alu_gen_directed_test::type_id::create("alu_direct_test_h",this);
  endfunction
  
  //if Sequence is not in between the raise and drop objetion then that will not be driven
  /*
  virtual task run_phase(uvm_phase phase);
    //phase.raise_objection(phase);
    //SQR and GEN connection
    agen_h.start(ae_h.alu_agnt_h.seqr);
    #50;
    //alu_direct_test_h.start(ae_h.alu_agnt_h.seqr);
    //phase.phase_done.set_drain_time(this,100);
    //phase.drop_objection(phase);
  endtask
  */
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(phase);
    //SQR and GEN connection
    agen_h.start(ae_h.alu_agnt_h.seqr);
    phase.phase_done.set_drain_time(this,100);
    phase.drop_objection(phase);
  endtask
  
  /*
  task reset_phase(uvm_phase phase);
    `uvm_info("TEST","I am in RESET phase",UVM_NONE);
  endtask
  
   task configure_phase(uvm_phase phase);
     phase.raise_objection(phase);
     `uvm_info("TEST","I am in CONFIGURE phase",UVM_NONE);
     //agen_h.start(ae_h.alu_agnt_h.seqr);
     phase.phase_done.set_drain_time(this,100);
     phase.drop_objection(phase);
  endtask
  */
  
endclass:alu_test
