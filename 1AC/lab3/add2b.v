module fac(input y,
                input x,
                input ci,
                output co,
                output z);
                assign {co,z}=x+y+ci;
endmodule
module add2b(input [1:0] x,
			input [1:0] y,
			input ci,
			output [1:0]z,
			output co
			);
wire tt;
fac instace1(
.y(y[0]),
.x(x[0]),
.ci(ci),
.z(z[0]),
.co(tt)
); 		
fac instace2(
.y(y[1]),
.x(x[1]),
.ci(tt),
.z(z[1]),
.co(co)
);
endmodule		
module add2b_tb;
    reg[1:0] y_tb;
	reg[1:0] x_tb;
	reg ci_tb;
    wire co_tb ;
	wire[1:0] z_tb;

    add2b instanta1(
        .y(y_tb),
        .x(x_tb),
        .ci(ci_tb),
        .co(co_tb),
        .z(z_tb)
    );
    integer i;
    initial begin
    { x_tb, y_tb, ci_tb} = 0;
    for (i = 0; i < 32; i = i + 1)
    begin
        #20 {x_tb , y_tb, ci_tb} = i;
        #20;
        $display("%b %b %b %b %b",x_tb ,y_tb,ci_tb,co_tb,z_tb);
    end
    #20;
    end
endmodule