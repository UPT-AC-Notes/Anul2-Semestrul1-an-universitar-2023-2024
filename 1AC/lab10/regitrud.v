module d_ff
(
    input clk, rst_b, set_b, input d, output reg  q
);
    always @ (posedge clk, negedge rst_b,negedge set_b)
        if (set_b==0)         begin         q <= 1; end
        else 
        begin
        if (rst_b==0)               q <= 0;
        else                q <= d;
        end
endmodule
module lfsr5b(
    input clk,
    input rst_b,
    //input d,
    output  [4:0] q
);
wire [4:0]aux;
d_ff d1(.clk(clk),.rst_b(1'b1),.set_b(rst_b),.d(aux[4]),.q(aux[0]));
d_ff d2(.clk(clk),.rst_b(1'b1),.set_b(rst_b),.d(aux[0]),.q(aux[1]));
d_ff d3(.clk(clk),.rst_b(1'b1),.set_b(rst_b),.d(aux[1]^aux[4]),.q(aux[2]));
d_ff d4(.clk(clk),.rst_b(1'b1),.set_b(rst_b),.d(aux[2]),.q(aux[3]));
d_ff d5(.clk(clk),.rst_b(1'b1),.set_b(rst_b),.d(aux[3]),.q(aux[4]));
assign q=aux;
endmodule
module lfsr5b_tb;
reg clk,rst_b;
wire[4:0] q;

lfsr5b i0(.clk(clk),.rst_b(rst_b),.q(q));
localparam CLK_PERIOD = 100, CLK_CYCLES = 35, RST_PULSE = 25;
initial begin
    clk = 0; repeat(2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1-clk;
end
initial begin
    rst_b = 0; #(RST_PULSE) rst_b=1;
end

endmodule
module sisr4b (
    input clk,
    input rst_b,
    input i,
    output [3:0] q
);
wire [3:0] aux;
generate
	genvar j;
	for(j=0;j<4;j=j+1) begin: vect
	
		if(j==0)
			begin
				d_ff d(.clk(clk),.rst_b(1'b1),.set_b(rst_b),.d(aux[3]^i),.q(aux[j]));
			end
		else
		begin
			if(j==1)
			begin
				d_ff d(.clk(clk),.rst_b(1'b1),.set_b(rst_b),.d(aux[0]^aux[3]),.q(aux[j]));
			end
			else
			d_ff d(.clk(clk),.rst_b(1'b1),.set_b(rst_b),.d(aux[j-1]),.q(aux[j]));
		end
	end
endgenerate
assign q=aux;
endmodule 
 
 module check (
 input [4 : 0] i ,
 output reg o
) ; 
//integer h;
always @(*)begin
    //for(h=0;h<32;h=h+1)
        if(i%4==1)
        begin
            o=1'b1;
        end
        else
        begin 
            o=1'b0;
        end
end 
endmodule
module bist(
    input clk,
    input rst_b,
    output [3:0]sig
);
wire[4:0] qbitst;
wire o;
lfsr5b lfsr5b_i(.clk(clk),.rst_b(rst_b),.q(qbitst));
check check_i(.i(qbitst),.o(o));
sisr4b sisr4b_i(.clk(clk),.rst_b(rst_b),.q(sig),.i(o));
endmodule

module bist_tb;
reg clk,rst_b;
wire[3:0] sig;

bist i0(.clk(clk),.rst_b(rst_b),.sig(sig));
localparam CLK_PERIOD = 100, CLK_CYCLES = 31, RST_PULSE = 25;
initial begin
    clk = 0; repeat(2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1-clk;
end
initial begin
    rst_b = 0; #(RST_PULSE) rst_b=1;
end

endmodule