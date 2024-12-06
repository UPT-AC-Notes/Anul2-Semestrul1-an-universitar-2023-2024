module fac(input y,
                input x,
                input ci,
                output co,
                output z);
                assign {co,z}=x+y+ci;
endmodule

module fac_tb;
    reg y_tb,x_tb,ci_tb;
    wire co_tb ,z_tb;

    fac instanta1(
        .y(y_tb),
        .x(x_tb),
        .ci(ci_tb),
        .co(co_tb),
        .z(z_tb)
    );
    integer i;
    initial begin
    { x_tb, y_tb, ci_tb} = 0;
    for (i = 0; i < 8; i = i + 1)
    begin
        #20 {x_tb , y_tb, ci_tb} = i;
        #20;
        $display("%b %b",co_tb,z_tb);
    end
    #20;
    end
endmodule
