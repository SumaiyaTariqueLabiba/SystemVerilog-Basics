// Code your design here
module UART_RX #( parameter DATA_BIT = 8,
                            STOP_TICK = 16)
  
                (input logic reset, clk,
                 input logic rx_data, c_tick, //c_tick from baud rate generator
                 output logic done_tick,
                 output logic [7:0] d_out);
  
  typedef enum {IDLE, START, DATA, STOP} state_type;
  
  state_type state_now, state_next;
  logic [3:0] s_now, s_next; //counter 
  logic [2:0] n_now, n_next; //number of databits
  logic [7:0] d_now, d_next; //data bits
  
  
  always_ff @(posedge reset, posedge clk)
    if(reset) begin
      state_now <= IDLE;
      s_now <= 0;
      n_now <= 0;
      d_now <= 0;
    end 
    else begin
      state_now <= state_next;
      s_now <= s_next;
      n_now <= n_next;
      d_now <= d_next;
    end 
  
  always_comb begin
    /*done_tick = 1'b0;  //instantiate
    s_next = s_now;
    n_next = n_now;
    d_next = d_now;
    state_next = state_now; */
    
    
    case(state_now)
      
      IDLE: 
        if(rx_data) begin  //detecting inputs
          s_next = 0;
          state_next = START;
        end
      
      
      START:
        if(c_tick) begin
          s_next = s_now + 1;
          
          if(s_now == 7) begin
            s_next = 0;
            n_next = 0;
            state_next = DATA;
          end 
        end
      
      
      DATA:
        if(c_tick) begin
          s_next = s_now + 1;
          
          if(s_now == 15) begin
            s_next = 0;
            d_next = rx_data ; /////////
            
            n_next = n_now + 1;
            if(n_now == (DATA_BIT-1)) begin
              state_next = STOP;
            end
            
          end 
        end
      
      
      STOP:
        if(c_tick) begin
          s_next = s_now + 1;
          
          if (s_now == (STOP_TICK-1)) begin          
            state_next = IDLE;
            done_tick = 1'b1;
          end 
        end 
          
    endcase 
  end 
  
  assign d_out = d_now;  //lastly assign data to output
  
endmodule:UART_RX