module FSM_design(w, clk, reset, z);
 input reg clk, w, reset;
 output reg z;
 reg[2:0]temp;
 parameter[2:0] s0=0, s1=1, s2=2, s3=3, s4=4;

 assign z=(temp == s4);

 always@(posedge clk, posedge reset)
  if (reset) temp<=s0;
  else begin
    case(temp)
      s0:if(w==1)temp<=s1;
         else temp<=s0;
      s1:if(w==1)temp<=s1;
         else temp<=s2;
      s2:if(w==1)temp<=s3;
         else temp<=s0; 
      s3:if(w==1)temp<=s1;
         else temp<=s4;
      s4:if(w==1)temp<=s3;
         else temp<=s0;
      default: temp<= 3'bxxx;
    endcase
  end
endmodule
