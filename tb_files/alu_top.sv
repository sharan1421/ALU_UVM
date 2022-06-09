// Code your testbench here
// or browse Examples

`include "interface.sv"
`include "package.sv"
`include "uvm_macros.svh"

import alu_pkg::*;
import uvm_pkg::*;

module test();
  
  alu_if aif();
  alu uut(.mode(aif.mode), .a(aif.a), .b(aif.b), .y(aif.y));
  
  initial
    begin
      uvm_config_db # (virtual alu_if)::set(null,"*","aif",aif);
      run_test();//no components instantiated
      //-voptargs=+acc=npr +UVM_TESTNAME=alu_test
      //for synopsys: +UVM_TESTNAME=alu_test2
    end
  
  initial
    begin
      $dumpfile("test.vcd");
      $dumpvars();
    end
  
endmodule:test


