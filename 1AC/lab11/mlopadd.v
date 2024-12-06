module mlopadd (
    input rst_b,clk, input [9:0]x, output [15:0] a
);
    wire [9:0] y;
    rgst #(.w(10)) i0(.clk(clk),.rst_b(rst_b),.clr(1'd0),.ld(1'd1),.d(x),.q(y));
    rgst #(.w(16)) i1(.clk(clk),.rst_b(rst_b),.clr(1'd0),.ld(1'd1),.d(y+a),.q(a));
endmodule

module mlopadd_tb;

reg rst_b,clk; 
reg [9:0]x;
wire [15:0]a;
integer k;
mlopadd i0(.clk(clk),.rst_b(rst_b),.x(x),.a(a));
localparam CLK_PERIOD = 100, CLK_CYCLES = 205, RST_PULSE = 25;
initial begin
    clk = 0; repeat(2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1-clk;
end
initial begin
    rst_b = 0; #(RST_PULSE) rst_b=1;
end
initial begin
    for (k = 1; k < 200 ; k = k + 1 ) begin
        x = 3*k-2; #CLK_PERIOD;
    end
    x = 0;
end

endmodule