module cmp2b(input [1:0] x,
			input [1:0] y,
			output eq,
			output it,
			output gt
			);
 assign	eq=(x[1])&(x[0])&(y[0])&(y[1])|	(~x[1])&(x[0])&(y[0])&(~y[1])|(x[1])&(~x[0])&(~y[0])&(y[1])|(~x[1])&(~x[0])&(~y[0])&(~y[1]);
 assign it=(x[1])&(~y[1])|(x[0])&(~y[0])&(~y[1])|(x[1])&(~x[0])&(y[0])&(y[1]);
 assign gt=(~x[1])&(y[1])|(~x[1])&(~x[0])&(y[0])|(x[1])&(x[0])&(~y[0])&(y[1]);
endmodule
module cmp4b(input [3:0] x,
			input [3:0] y,
			output eq,
			output it,
			output gt
			);
wire t1,t2,t3,h1,h2,h3;
cmp2b instace1(
.y(y[3:2]),
.x(x[3:2]),
.eq(t1),
.it(t2),
.gt(t3)
); 		
	cmp2b instace2(
	.y(y[1:0]),
	.x(x[1:0]),
	.eq(h1),
	.it(h2),
	.gt(h3)
	);
assign eq=t1&h1;
assign it=t2|t1&h2;
assign gt=t3|t1&h3;
endmodule		
module cmp4b_tb;
    reg[3:0] y_tb;
	reg[3:0] x_tb;
	wire eq;
	wire it;
	wire gt;

    cmp4b instanta1(
        .y(y_tb),
        .x(x_tb),
		.eq(eq),
		.it(it),
		.gt(gt)
    );
    integer i;
    initial begin
    { x_tb, y_tb} = 0;
    for (i = 0; i < 256; i = i + 1)
    begin
        #20 {x_tb , y_tb} = i;
        #20;
        $display("%b %b %b %b %b",x_tb ,y_tb,eq,it,gt);
    end
    #20;
    end
endmodule