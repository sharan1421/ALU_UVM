//class alu_coverage extends uvm_subscriber#(alu_transaction);
class alu_coverage extends uvm_component;
  `uvm_component_utils(alu_coverage)
  //Analysis Implementation port
  uvm_analysis_imp #(alu_transaction, alu_coverage) alu_cov_ap_imp;
  alu_transaction at_h;
  
  real cov_stat;
  
  
  //COVER GROUP
  covergroup cg () ;
    c1: coverpoint at_h.a {bins b1[]={[1:15]};//multibinning
                          bins b2 = default;}
    c2: coverpoint at_h.b;//automatic bins considered here
    c3: coverpoint at_h.mode;
    c4: cross c1,c2;
  endgroup : cg
  
  function new(string name="COV",uvm_component p);
    super.new(name,p);
    alu_cov_ap_imp = new("alu_cov_ap_imp",this);
    cg = new;//create an instance of cover group
  endfunction
  
  
  /*
  function new();
    cg = new;//create an instance of cover group
    endfunction
    */
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    at_h = alu_transaction::type_id::create("at_h");
  endfunction
  
  virtual function void write(alu_transaction t);
    at_h = t;
    `uvm_info("COV",$sformatf("Data received from MONITOR a=%0d::b=%0d::mode=%0d::y=%0d",t.a,t.b,t.mode,t.y),UVM_NONE);
         //sampling of the covergroup
    cg.sample();
    cov_stat=cg.get_coverage();
  endfunction
  
  //work around to see coverage
  virtual function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    $display("****[Coverage stats:%f]*****",cov_stat);
  endfunction
  
endclass:alu_coverage
