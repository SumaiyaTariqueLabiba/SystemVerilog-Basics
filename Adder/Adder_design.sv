// Code your design here
module adder_design(input logic [7:0] a,
 input logic [7:0] b,
 input logic c_in,
 output logic [7:0] sum,
 output logic c_out);

 assign {c_out, sum}=a+b+c_in;

endmodule: adder_design