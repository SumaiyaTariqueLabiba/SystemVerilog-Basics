module testbench_adder();
logic [7:0] a;
logic [7:0] b;
logic c_in;
logic [7:0] sum;
logic c_out;

//DUT instantiate 
adder_design adder_tb(.a(a_tb), .b(b_tb), .c_in(c_in_tb), .sum(sum_tb), .c_out(c_Out_tb));
 
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
    $dumpfile("dump_adder.vcd");
    $dumpvars;
end

endmodule: textbench_adder