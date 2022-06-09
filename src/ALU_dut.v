// Code your design here
/*
 Design a testbench for the Combinational Circuit RTL mentioned in the Instruction tab.
*/

module alu
(
  input [1:0] mode,
  input [3:0] a,b,
  output reg [7:0] y
);
  
  always@(*)
    begin
      case(mode)
        2'b00: y = a + b;
        2'b01: y = a - b;
        2'b10: y = a * b;
        2'b11: y = a / b;
      endcase
    end
endmodule 
