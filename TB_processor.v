`timescale 10ns/10ns
module TB_processor;
	reg clk,rst;
	processor processor_inst(clk,rst);
	initial begin
		$display("Here we start");
		clk=0;
		rst=1;
		#7 rst=0;
		//#20 $finish;
	end
	always #5 clk = ~clk;
	
endmodule
