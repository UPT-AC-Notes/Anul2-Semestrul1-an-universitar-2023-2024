module mschdpath (
    input clk, rst_b,ld_merg,upd_mreg, input [511:0] blk, output [31:0] m0
);
    function [31:0] RtRot(input [31:0] x, input [4:0] p);
        reg [63:0] tmp; begin
        tmp = {x, x} >> p; RtRot = tmp[31:0];end
    endfunction

    function [31:0] Sgm0(input [31:0]x); begin
        Sgm0=RtRot(x,7)^RtRot(x,18)^(x>>3);end
    endfunction
    function [31:0] Sgm1(input [31:0]x); begin
        Sgm1=RtRot(x,17)^RtRot(x,19)^(x>>10);end
    endfunction
    function [31:0] Mux(input sel,input [31:0]d1,d0); begin
        Mux = (sel) ?  d1 : d0 ;end
    endfunction
    function [31:0] Word32(input [511:0]blk, input [3:0]idx); begin
        Word32 = blk[511-32*idx -:32];end
    endfunction

    wire [31:0] m[0:15];
    generate
        genvar k;
        for( k = 0; k < 16; k = k +1) begin:some_name
            if(k < 15)
                rgst #(.w(32)) i0(.clk(clk),.rst_b(rst_b),.clr(1'd0),.ld(upd_mreg),.d(Mux(ld_merg,Word32(blk,k),m[k+1])),.q(m[k]));
            else
                rgst #(.w(32)) i0(.clk(clk),.rst_b(rst_b),.clr(1'd0),.ld(upd_mreg),.d(Mux(ld_merg,Word32(blk,k),m[0] + Sgm0(m[1]) + m[9] + Sgm1(m[14]))),.q(m[k]));
        end
    endgenerate
    assign m0 = m[0];
endmodule

module mschdpath_tb;

reg clk,rst_b,ld_merg,upd_mreg;
reg [511:0] blk; wire [31:0]m0;
mschdpath i0(.clk(clk),.rst_b(rst_b),.ld_merg(ld_merg),.upd_mreg(upd_mreg),.blk(blk),.m0(m0));


localparam CLK_PERIOD = 100, CLK_CYCLES = 205, RST_PULSE = 25;
initial begin
    clk = 0; repeat(2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1-clk;
end
initial begin
    rst_b = 0; #(RST_PULSE) rst_b=1;
end
initial begin
    {ld_merg,upd_mreg} = 3; #CLK_PERIOD {ld_merg,upd_mreg} = 1;     
end
initial begin
blk = 'h61626364303132338 << 444 | 8'h40;end
endmodule