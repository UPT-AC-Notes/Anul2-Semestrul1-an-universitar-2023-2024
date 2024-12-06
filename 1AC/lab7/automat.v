module D_FF(input clk, D, output reg Q,output reg Q_b);
	
    initial begin
        Q <= 0;
        Q_b <= 1;
    end
	
    always @(posedge clk) begin
        Q <= D;
        Q_b <= ~D;
    end
endmodule

module ripple_counter_4bit(input clk, output  [3:0] Q);
	wire [3:0]aux;
    D_FF inst1 (.clk(clk), .D(aux[0]), .Q(Q[0]), .Q_b(aux[0]));
    generate
        genvar i;
        for(i=1; i<4; i=i+1)
        begin: vect
            D_FF inst(.clk(aux[i-1]), .D(aux[i]), .Q(Q[i]), .Q_b(aux[i]));
        end
    endgenerate
endmodule

module sipo_shift_register_design(input clk,output[3:0]Q);
wire [3:0]aux;
	assign aux=4'b0;
D_FF dut1(.clk(clk),.D(aux[0]),.Q(Q[0]),.Q_b(aux[0]));
D_FF dut2(.clk(aux[0]),.D(aux[1]),.Q(Q[1]),.Q_b(aux[1]));
D_FF dut3(.clk(aux[1]),.D(aux[2]),.Q(Q[2]),.Q_b(aux[2]));
D_FF dut4(.clk(aux[2]),.D(aux[3]),.Q(Q[3]),.Q_b(aux[3]));

endmodule

module ripple_counter_4bit_tb;
    reg clk;
    wire[3:0] Q;

    ripple_counter_4bit uut (.clk(clk), .Q(Q));

    initial begin
        clk = 0;
        repeat(200) #5 clk = ~clk;
    end
endmodule