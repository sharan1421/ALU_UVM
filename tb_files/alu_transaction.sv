class alu_transaction extends uvm_sequence_item;
  
  //"bit" is 2 state data type with user defined length.
  rand bit [3:0] a;
  rand bit [3:0] b;
  rand bit [1:0] mode;
  bit [7:0] y;
  
  `uvm_object_utils_begin(alu_transaction)
  `uvm_field_int(a, UVM_ALL_ON)
  `uvm_field_int(b, UVM_ALL_ON)
  `uvm_field_int(mode, UVM_ALL_ON)
  `uvm_field_int(y, UVM_ALL_ON)
  `uvm_object_utils_end
  
  
  function new(string name="TRANS");
    super.new(name);
  endfunction
  
  constraint one{a > b;};
  
  //fail:catching divide by 0
  constraint two{if(mode==2'b11)
                b!=0;};
  
endclass:alu_transaction
  
