// Code your testbench here
module ALU_testbench();
  logic [3:0]out; 
  logic sign,carr,zero; 
  logic [11:0]in;
  
//DUT instantiate 
  ALU_design DUT(   .in(in),
                    .sign(sign),
                    .carr(carr),
                    .zero(zero),
                    .out(out));
 /* //clock generating
 initial begin
   logic clk=0;
   forever #5 clk=~clk;
 end */
 
initial begin
  #10 in=12'b000100001100;  //NOT
  #10 in=12'b110110100010; //ADD
  #10 in=12'b100100110101; //AND
  #10 in=12'b010100100010; //MUL
  #10 in=12'b110001110110; //NAND
  #10 in=12'b001010010001; //SUBTRACT with carry
  #10 in=12'b001110110011; //XNOR
  #10 in=12'b011000010100; //NOR
  
  #10 in=12'b111110100000; //default
  #10 in=12'b000010100000; //default 
end
  
initial begin
  #10;
  $monitor ($time," in=%b, out=%b, sign=%b, carr=%b, zero=%b",in,out,carr,sign,zero);

  #130 $finish;
end    
  
initial begin
  $dumpfile("alu.vcd");
  $dumpvars;
end
  
endmodule: ALU_testbench 