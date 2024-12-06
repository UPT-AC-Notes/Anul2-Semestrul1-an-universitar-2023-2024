module mux_2s #(
 parameter w = 4
 ) (
 input [ w-1: 0] d0 , d1 , d2 , d3 , 
 input [ 1 : 0 ] s , 
 output [ w-1: 0] o 
 );

assign o=(s==0)?d0:{w{1'bz}};
assign o=(s==1)?d1:{w{1'bz}};
assign o=(s==2)?d2:{w{1'bz}};
assign o=(s==3)?d3:{w{1'bz}};
endmodule

module mux_2s_tb;
reg [3:0] d0,d1,d2,d3;
reg [1:0] s;
wire [3:0] o;
mux_2s dut(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .s(s),
    .o(o)
);

integer k;
	initial begin
		$display("Time\ti\to");
		$monitor("%0t\t%b\t%b\t%b\t%b\t%b", $time,d0,d1,d2,d3,o);
		d0=2;d1=3;d2=1;d3=0;
        s=0;
		for (k = 0; k < 4; k = k + 1)
			#20 s=k;
	end
 
endmodule


