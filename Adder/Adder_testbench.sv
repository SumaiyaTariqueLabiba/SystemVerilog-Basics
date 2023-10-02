// Code your testbench here
module testbench_adder();
logic [7:0] a;
logic [7:0] b;
logic c_in;
logic [7:0] sum;
logic c_out;

//DUT instantiate 
adder_design adder_tb(.a(a), .b(b), .c_in(c_in), .sum(sum), .c_out(c_Out));
 
initial begin
    #10 a=0; b=0; c_in=1;
    #10 a=1; b=0; c_in=1;
    #10 a=0; b=1; c_in=1;
    #10 a=1; b=1; c_in=1;
    
    #10 a=0; b=0; c_in=0;
    #10 a=1; b=0; c_in=0;
    #10 a=1; b=0; c_in=0;
    #10 a=1; b=1; c_in=0;
end
initial begin
    $monitor ($time, "a=%b, b=%b, c_in=%b, sum=%b, c_out=%b", a , b, c_in, sum, c_out);
     
    #100 $finish;
end

initial begin
    $dumpfile("adder.vcd");
    $dumpvars;
end

endmodule: testbench_adder