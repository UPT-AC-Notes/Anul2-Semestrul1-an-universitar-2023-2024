module cnt1s (
  input [5:0] i,
  output reg [3:0] o
);
integer j=0,k=0;
  always @(*)begin	
	k=0;
	for( j=0;j<=5;j=j+1)
	begin
		if(i[j]&1)
		k=k+1;
	end
	o=k;
  end
endmodule

module cnt1s_tb;
  reg [5:0] i;
  wire [3:0] o;

  cnt1s cnt1s_i (.i(i), .o(o));

  integer k;
  initial begin
    $display("Time\ti\t\to");
    $monitor("%0t\t%b(%2d)\t%b(%0d)", $time, i, i, o, o);
    i = 0;
    for (k = 1; k < 64; k = k + 1)
      #10 i = k;
  end
endmodule