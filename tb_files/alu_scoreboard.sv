//component for coverage is "uvm_subscriber"
//connect this to component thorugh IMPLEMENTATION PORT in env with the monitor

class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)
  //Analysis Implementation port
  uvm_analysis_imp #(alu_transaction, alu_scoreboard) alu_ap_imp;
  alu_transaction at_h;
  alu_generator agen_h;
  
  function new(string name="SCOB", uvm_component p);
    super.new(name,p);
    alu_ap_imp = new("alu_ap_imp",this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    at_h = alu_transaction::type_id::create("at_h");
    agen_h = alu_generator::type_id::create("agen_h",this);
  endfunction
  
  int matched, mismatched;
  
  //REFERENCE MODEL
  function logic [7:0] ref_model(input logic [3:0] a, b, input logic [1:0] op_mode);
    case(op_mode)
      2'b00 : return a + b;
      2'b01 : return a - b;
      2'b10 : return a * b;
      2'b11 : return a / b;
    endcase
  endfunction
  
  
  //WRITE method for analysis implementation port
  virtual function void write(alu_transaction t);
    at_h = t;
    `uvm_info("SCOB",$sformatf("Data received from MONITOR a=%0d::b=%0d::mode=%0d::y=%0d",t.a,t.b,t.mode,t.y),UVM_NONE);
              //comparison logic
     /*
    Error-[SE] Syntax error
  Following verilog source has syntax error :
  "scoreboard.sv", 39: token is 'else'
      else
          ^

1 error
CPU time: .641 seconds to compile
Exit code expected: 0, received: 1
*/
    // This error is because begin end is missing for if and else. Whenever they include 
    
    if(ref_model(at_h.a,at_h.b,at_h.mode) == at_h.y)
    //if(ref_model(t.a,t.b,t.mode) == t.y)
      begin
      `uvm_info("SCOB","****TEST IS PASSED****",UVM_NONE);
        matched++;
        //`uvm_info("SCOB",$sprint("%s",at_h.print()),UVM_NONE);
       // at_h.print();
        //`uvm_info("SCOB",$sformatf("The Total number of matched test cases are:[%0d]",matched),UVM_NONE);
        //use final phase else 10 times will be printed.
      end
    else
      begin
      `uvm_error("SCOB","****TEST IS FAILED****");
        mismatched++;
        //`uvm_info("SCOB",$sprint("%s",at_h.print()),UVM_NONE);
          at_h.print();
       // `uvm_info("SCOB",$sformatf("The Total number of mismatched test cases are:[%0d]",mismatched),UVM_NONE);
      end
      
  endfunction
  
  virtual function void final_phase(uvm_phase phase);
    super.final_phase(phase);
    
    `uvm_info("SCOB",$sformatf("The Total number of matched test cases for ALU are:[%0d]",matched),UVM_NONE);
    
    `uvm_info("SCOB",$sformatf("The Total number of mismatched test cases for ALU are:[%0d]",mismatched),UVM_NONE);
    
    
   // `uvm_info("SCOB",$sformatf("The Total number of mismatched test cases for ALU are:[%0d] and failed sequence is:a=%0d::b=%0d::mode=%0d",mismatched,at_h.a,at_h.b,at_h.mode),UVM_NONE);
    
  endfunction
  
endclass:alu_scoreboard
