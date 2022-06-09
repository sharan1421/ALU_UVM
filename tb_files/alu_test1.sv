class alu_test1 extends alu_test;
  `uvm_component_utils(alu_test1)
  
  function new(string name="TEST1", uvm_component p);
    super.new(name,p);
    endfunction
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
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
    //phase.raise_objection(phase);
    //Non-hierarchical object error will come if phase used
    phase.raise_objection(this);
    //SQR and GEN/SEQ connection
    agen_test_h.start(ae_h.alu_agnt_h.seqr);
    phase.phase_done.set_drain_time(this,100);
    phase.drop_objection(this);
  endtask
  
  
endclass:alu_test1
