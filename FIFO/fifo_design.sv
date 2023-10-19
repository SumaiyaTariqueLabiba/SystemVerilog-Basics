// Code your testbench here
// or browse Examples
module fifo_design #(parameter DATAWIDTH = 8,
                     parameter DATADEPTH = 16)
  
                    (input wire clk, 
                     input wire reset,
                     input wire en_write, 
                     input wire en_read,
                     input reg [7:0] data_in,
                     output reg [7:0] data_out,
                     output reg full_fifo,
                     output reg empty_fifo);

  reg [4:0] write_addr;  //'d16 = 'b10000 thus 5           
  reg [4:0] read_addr;
  reg [DATAWIDTH-1:0] memory [0:DATADEPTH-1]; 
  
  //write 
  always@(posedge clk, posedge reset) begin
    if(reset)
      write_addr <= 0;
    else if(en_write && !full_fifo)
      write_addr <= write_addr + 1; 
  end 
  
  
  //read
  always@(posedge clk, posedge reset) begin
    if(reset)
      read_addr <= 0;
    else if (en_read && !empty_fifo)
      read_addr <= read_addr + 1;
  end 
  
  //memory writing
always@(posedge clk, posedge reset) begin
  if(en_write && !full_fifo)
    memory[write_addr] <= data_in;
  else if(reset)
    memory[write_addr] <= 0;  /// 
end
  
  
  //full_fifo
  always@(posedge clk, posedge reset) begin
    if(reset)
      full_fifo <= 0;
    else if(en_write && write_addr == read_addr)
      full_fifo <= 1;
    else if(en_read && !empty_fifo)
      full_fifo <= 0;
    else 
      full_fifo <= 0;
  end
  
  //empty fifo
  always@(posedge clk, posedge reset) begin
    if(reset)
      empty_fifo <= 1;
    else if(en_read && (write_addr == read_addr + 1))
      empty_fifo <= 1;
    else if(en_write && !full_fifo && (write_addr != read_addr))
      empty_fifo <= 0;
    else 
      empty_fifo <= 0;
  end
  
  //output
 initial begin
   if(empty_fifo)
     data_out <= 'hx;
   else 
     data_out <= memory[read_addr];
 end
  
endmodule:fifo_design