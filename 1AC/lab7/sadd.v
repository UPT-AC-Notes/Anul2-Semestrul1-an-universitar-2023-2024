module sadd(input clk, rst_b, x,y,output z);
	localparam s0 = 0, s1 = 1;
	reg st, st_nxt;
	always @(*) 
	case (st)
		s0:if(x&y)      st_nxt = s1;
			else        st_nxt = s0;
		s1:if(~x&(~y))  st_nxt = s0;
			else        st_nxt = s1;   
	endcase
	assign z = x^y^st;
		always @(posedge clk, negedge rst_b )
	 if( ! rst_b )      st <= s0 ;
	 else               st <= st_nxt ;
endmodule

module sadd_tb;
reg clk, rst_b, x, y;
wire z;
sadd i0(.clk(clk), .rst_b(rst_b), .x(x), .y(y), .z(z));
localparam  CLK_PERIOD = 100, CLK_CYCLES = 6, RST_PULSE = 25;
initial begin
    clk = 0; repeat(2*CLK_CYCLES) #(CLK_PERIOD/2) clk=~clk;
end
initial begin
    rst_b = 0; #RST_PULSE rst_b = 1;
end
initial begin
                        x = 1; y = 0;
    #(1*CLK_PERIOD)     y = 1;
    #(3*CLK_PERIOD)     x = 0; y = 0;
end
endmodule