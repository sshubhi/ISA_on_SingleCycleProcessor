module alu (
input [31:0] data_1,
input [31:0] data_2,
input [5:0]  alu_control,
output reg zero,
output reg [31:0] alu_out
);

//alu_control = {alu_op,func_code}
always @ (*)
begin
	case (alu_control[5:4])
		2'b01: 	     begin
			  	case (alu_control[3:0])
					4'b0000: begin alu_out = data_1 + data_2; end
					4'b0001: begin alu_out = data_1 - data_2; end
					4'b0100: begin alu_out = data_1 & data_2; end
					4'b0101: begin alu_out = data_1 | data_2; end
					4'b0110: begin alu_out = data_1 ^ data_2; end
					4'b1100: begin alu_out = ~(data_1 & data_2); end
					4'b1101: begin alu_out = ~(data_1 | data_2); end
					4'b1110: begin alu_out = ~(data_1 ^ data_2); end
					4'b1011: begin alu_out = {(data_2<<16),{16{1'b0}}}; end
					default: begin /* FIXME */ end
			  	endcase
		             end	
		2'b00,2'b11: begin
			  	case (alu_control[3:0])
					4'b0000: begin /*FIXME False */ alu_out = 32'b0; end
					4'b0001: begin alu_out = (data_1 == data_2) ? 32'b1: 32'b0; end
					4'b0010: begin alu_out = (data_1 < data_2)  ? 32'b1: 32'b0; end
					4'b0011: begin alu_out = (data_1 <= data_2) ? 32'b1: 32'b0; end
					
					4'b0101: begin alu_out = (data_1 == 32'b0) ? 32'b1: 32'b0 ; end
					4'b0110: begin alu_out = (data_1 < 32'b0) ? 32'b1: 32'b0; end
					4'b0111: begin alu_out = (data_1 <= 32'b0) ? 32'b1: 32'b0; end
					4'b1000: begin /* FIXME True */  alu_out = 32'b1; end
					4'b1001: begin alu_out = (data_1 != data_2) ? 32'b1: 32'b0; end
					4'b1010: begin alu_out = (data_1 >= data_2) ? 32'b1: 32'b0; end
					4'b1011: begin alu_out = (data_1 > data_2) ? 32'b1: 32'b0; end
					
					4'b1101: begin alu_out = (data_1 != 32'b0) ? 32'b1: 32'b0; end
					4'b1110: begin alu_out = (data_1 >= 32'b0) ? 32'b1: 32'b0; end
					4'b1111: begin alu_out = (data_1  > 32'b0) ? 32'b1: 32'b0; end
					default: begin /* FIXME */ end		
			  	endcase			   
		       	     end	
		
	endcase
	//For branch statement, set the zero flag
	if (alu_control[5:4] == 2'b11)
	begin
		zero = (alu_out == 32'b1) ? 1'b1 : 1'b0;
	end
end
endmodule
