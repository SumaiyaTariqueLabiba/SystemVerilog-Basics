module FSM_testbench;
  reg clk, w, reset;
  reg z;
  
  reg expectedz=0; 
  reg [31:0] i;
  
  logic [2:0] testvector [1000:0];  //[2:0] as 1_1_0
  
  FSM_design DUT(.clk(clk),   //DUT connect
                 .w(w),
                 .reset(reset),
                 .z(z)
                );
  initial begin      //clock generating 
    clk=0;
    forever #5 clk=~clk;
  end   
   
 initial begin
   $readmemb ("FSM_testvector.txt",testvector);  
  i=0;      //initializing 
 end 
   
  always@(posedge clk) begin
    {reset,w,expectedz} = testvector[i]; 
  end
  
  always@(posedge clk) begin
    if (z!==expectedz) begin
      $display ($time," z=%b isn't expected",z);
    end
    i++;
  end
  
  initial begin
    $monitor ($time ," reset=%b, w=%b, expectedz=%b, z=%b", reset,w,expectedz,z);
    #120 $finish;
  end
  
  initial begin
    $dumpfile("fsm.vcd");
    $dumpvars;
  end  
    
endmodule  
