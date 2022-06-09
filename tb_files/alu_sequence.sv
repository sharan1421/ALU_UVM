//BASE SEQUENCE

class alu_generator extends uvm_sequence # (alu_transaction);
  `uvm_object_utils(alu_generator)
  
  alu_transaction at_h;
  integer i;
  
  function new(string name="GEN");
    super.new(name);
  endfunction
  
 /* virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    at_h = alu_transaction::type_id::cretae("at_h",this);
  endfunction*/
  
  //In Sequence/Generator we should not use phases.
  
  virtual task body();
    at_h = alu_transaction::type_id::create("at_h");
    
    //for(i =0 ; i<100; i++)
    for(int i =0 ; i<10; i++)
    //  for(int i =0 ; i<5; i++)
      begin
        start_item(at_h);
        `uvm_info("GEN",$sformatf("****The SEQUENCE at the iteration::[ %0d ] is****",i),UVM_NONE);
        void'(at_h.randomize());
        `uvm_info("GEN",$sformatf("The Generator stimulus is: a=%0d, b=%0d, mode = %0d",at_h.a, at_h.b, at_h.mode),UVM_NONE);
       // at_h.print(uvm_default_line_printer);
        finish_item(at_h);
        #10;
      end
    
    for(int i =0 ; i<100; i++)  
      begin
        start_item(at_h);
        `uvm_info("GEN",$sformatf("****The SEQUENCE at the iteration::[ %0d ] is****",i),UVM_NONE);
        void'(at_h.randomize());
        `uvm_info("GEN",$sformatf("The Generator stimulus is: a=%0d, b=%0d, mode = %0d",at_h.a, at_h.b, at_h.mode),UVM_NONE);
       // at_h.print(uvm_default_line_printer);
        finish_item(at_h);
        #10;
      end
    
  endtask
  
endclass:alu_generator

//Derived test for Directed testcase
// covering for remaining values of "mode" for all operators.


class alu_gen_directed_test extends uvm_sequence # (alu_transaction);
  `uvm_object_utils(alu_gen_directed_test)
  alu_transaction at_h;
  
  function new(string name="GEN1");
    super.new(name);
  endfunction
  
  virtual task body();
    at_h = alu_transaction::type_id::create("at_h");
    start_item(at_h);
    at_h.randomize();
    at_h.mode = 2'b00;
    finish_item(at_h);
     #5;
    
    start_item(at_h);
    at_h.randomize();
    at_h.mode = 2'b01;
    finish_item(at_h);
     #5;
    
    start_item(at_h);
    at_h.randomize();
    at_h.mode = 2'b10;
    finish_item(at_h);
     #5;
    
    start_item(at_h);
    at_h.randomize();
    at_h.mode = 2'b11;
    finish_item(at_h);
     #5;
    
  endtask
  
endclass:alu_gen_directed_test
