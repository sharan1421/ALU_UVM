class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)
  alu_transaction at_h;
  virtual alu_if aif;
  
  //analysis port
  uvm_analysis_port # (alu_transaction) alu_ap;
  
  function new(string name="MON", uvm_component p);
    super.new(name,p);
    alu_ap = new("alu_ip",this);             
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    at_h = alu_transaction::type_id::create("at_h",this);
    if(!uvm_config_db # (virtual alu_if)::get(this,"","aif",aif))
      `uvm_fatal("MON","Unable to connect to CONFIG DB")
  endfunction
    
  virtual task run_phase(uvm_phase phase);
    forever
      begin
       // #10;
       // @(aif.a or aif.b or aif.mode);
        
        //in line 25 the output change is not detecetd and scoreboard is detecting in some other time so 9 tests are failing
        
        @(aif.a or aif.b or aif.mode or aif.y);
        #1;//work around for monitor.with single monitor.at time 0 happening fail and pass due to regions
        
       // @(aif.y);
        
        //begin
        //at_h = alu_transaction::type_id::create("at_h",this);
        //=========================================
        // interface values are assigned to trans.
        //  (Trans = Interface) and sent to SCOB
        //=========================================
        at_h.a = aif.a;
        //@(aif.b);
        at_h.b = aif.b;
        //@(aif.mode);
        at_h.mode = aif.mode;
        //@(aif.y);
        at_h.y = aif.y;
        `uvm_info("MON",$sformatf("Data sent to scoreboard a=%0d::b=%0d::mode=%0d::y=%0d",at_h.a,at_h.b,at_h.mode,at_h.y),UVM_NONE);
        at_h.print(uvm_default_line_printer);
        alu_ap.write(at_h);
      end
  endtask
  
endclass:alu_monitor
    
    //for 15 iterations one etst failed
/*
UVM_INFO generator.sv(27) @ 120: uvm_test_top.ae_h.alu_agent_h.seqr@@agen_h [GEN] ****The SEQUENCE at the iteration::[ 12 ] is****
UVM_INFO generator.sv(29) @ 120: uvm_test_top.ae_h.alu_agent_h.seqr@@agen_h [GEN] The Generator stimulus is: a=11, b=0, mode = 3
UVM_INFO driver.sv(28) @ 120: uvm_test_top.ae_h.alu_agent_h.ad_h [alu_driver] Triggered DUT and a=11, b=0, mode = 3
at_h: (alu_transaction@618) { a: 'hb  b: 'h0  mode: 'h3  y: 'h0  begin_time: 120  depth: 'd2  parent sequence (name): agen_h  parent sequence (full name): uvm_test_top.ae_h.alu_agent_h.seqr.agen_h  sequencer: uvm_test_top.ae_h.alu_agent_h.seqr  } 
UVM_INFO monitor.sv(38) @ 120: uvm_test_top.ae_h.alu_agent_h.am_h [MON] Data sent to scoreboard a=11::b=0::mode=3::y=0
at_h: (alu_transaction@588) { a: 'hb  b: 'h0  mode: 'h3  y: 'h0  } 
UVM_INFO scoreboard.sv(36) @ 120: uvm_test_top.ae_h.as_h [SCOB] Data received from MONITOR a=11::b=0::mode=3::y=0
UVM_INFO scoreboard.sv(61) @ 120: uvm_test_top.ae_h.as_h [SCOB] ****TEST IS FAILED****
*/
