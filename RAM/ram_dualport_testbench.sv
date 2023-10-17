module ram_testbench;
  logic clk;
  logic en_a, en_b;
  logic [4:0] addr_a, addr_b;
  logic [7:0] data_in_a, data_in_b;
  logic [7:0] data_out_a, data_out_b;
  logic [7:0] out_a_tb, out_b_tb; //testbench outputs
  logic [7:0] ram [31:0];
  
  ram_design DUT(.clk(clk), 
                 .en_a(en_a), 
                 .en_b(en_b), 
                 .addr_a(addr_a), 
                 .addr_b(addr_b), 
                 .data_in_a(data_in_a), 
                 .data_in_b(data_in_b), 
                 .data_out_a(data_out_a), 
                 .data_out_b(data_out_b));
                
   initial begin
     clk = 0;
     forever #10 clk = ~clk;
   end 
  
   initial begin
     repeat (1) begin
        execute;
        en_a = 0;
        en_b = 0;
     end
     repeat (10) begin
        execute;
        en_a = 1;
        en_b = 1;
     end
     
     if(en_a) begin
       ram [addr_a] <= data_in_a; //attempt: to generate testbench outputs
      out_a_tb <= data_in_a;
     end
     else begin 
      out_a_tb <= ram [addr_a];
     end
     
     if(en_b) begin
      ram [addr_b] <= data_in_b;
      out_b_tb <= data_in_b;
     end
     else begin 
      out_b_tb <= ram [addr_b];
     end
     
   end

   task execute;
     begin
      @(posedge clk)
      addr_a = $random;
      data_in_a = $random;
      addr_b = $random;
      data_in_b = $random;    
      end
   endtask
  
  
   initial begin                    //comparing testbench outputs with design outputs
     if(!(out_a_tb == data_out_a) && (out_b_tb == data_out_b)) begin
       $display ($time," Transaction failed!\nDesign output A = %b, Testbench output A = %b \nDesign output B = %b, Testbench output B = %b",data_out_a,out_a_tb,data_out_b,out_b_tb);
     end
     else 
       $display ($time," Transaction successful");
     
     #180 $finish;
   end
  
   initial begin
     $dumpfile("ram.vcd");
     $dumpvars;
   end
  
endmodule:ram_testbench