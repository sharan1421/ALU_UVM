class alu_driver extends uvm_driver #(alu_transaction);
  `uvm_component_utils(alu_driver)
  
  virtual alu_if aif;
  alu_transaction at_h;
  
  function new(string name="DRV",uvm_component p);
    super.new(name,p);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    at_h = alu_transaction::type_id::create("at_h");
    if(!uvm_config_db # (virtual alu_if)::get(this,"","aif",aif))
      `uvm_fatal("DRV","Unable to connect to CONFIG DB")
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever
      begin
        seq_item_port.get_next_item(at_h);
        //=========================================
        // trans. values are assigned to interface
        //  (Interface = Trans.) and sent to MON
        //=========================================
        aif.a = at_h.a;
        aif.b = at_h.b;
        aif.mode = at_h.mode;
        //get_name:Handle of class will printed
        //get_type_name::Class name will print
        
        `uvm_info(get_type_name(),$sformatf("Triggered DUT and a=%0d, b=%0d, mode = %0d. y = %0d",at_h.a,at_h.b,at_h.mode,at_h.y),UVM_NONE);
        at_h.print(uvm_default_line_printer);
        seq_item_port.item_done();
      end
  endtask
  
endclass:alu_driver
