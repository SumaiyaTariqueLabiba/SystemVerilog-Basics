module ram_design(input logic clk,
                  input logic en_a, en_b, //enable to write/read
                  input logic [4:0] addr_a, addr_b,
                  input logic [7:0] data_in_a, data_in_b,
                  output logic [7:0] data_out_a, data_out_b
                  );
  
  logic [7:0] ram [31:0];
  
  always@(posedge clk)   //port a
    if(en_a) begin
      ram [addr_a] <= data_in_a; //writing data in ram
      data_out_a <= data_in_a;
    end
    else begin 
      data_out_a <= ram [addr_a]; //read from ram
    end
  
  always@(posedge clk)  //port b
    if(en_b) begin
      ram [addr_b] <= data_in_b;
      data_out_b <= data_in_b;
    end
    else begin 
      data_out_b <= ram [addr_b];
    end
  
endmodule:ram_design
