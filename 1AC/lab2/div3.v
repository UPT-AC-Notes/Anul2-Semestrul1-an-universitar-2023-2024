module div3 (
  input [3:0] i,
  output reg [2:0] o
);
  always @(*)
	casez(i)
		4'b0000 : o= 3'b000;
		4'b0001 : o= 3'b000;
		4'b0010 : o= 3'b000;
		4'b0011 : o= 3'b001;
		4'b010? : o= 3'b001;
		4'b011? : o= 3'b010;
		4'b1000 : o= 3'b010;
		4'b1001 : o= 3'b011;
		4'b101? : o= 3'b011;
		4'b110? : o= 3'b100;
		4'b1110 : o= 3'b100;
		4'b1111 : o= 3'b101;
	endcase
endmodule

module div3_tb;
  reg [3:0] i;
  wire [3:0] o;

  div3 div3_i (.i(i), .o(o));

  integer k;
  initial begin
    $display("Time\ti\t\to");
    $monitor("%0t\t%b(%2d)\t%b(%0d)", $time, i, i, o, o);
    i = 0;
    for (k = 1; k < 16; k = k + 1)
      #10 i = k;
  end
endmodule