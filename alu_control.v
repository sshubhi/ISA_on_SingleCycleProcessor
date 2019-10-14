module alu_control (
input [3:0] opcode,
input [3:0] func,
input [3:0] func_imm_lw,
input [3:0] func_br_sw,
output reg [5:0] alu_ctrl
);

// alu_ctrl = {alu_op,func}
always @ (*)
begin
	case(opcode)
		//R-type arithmetic instr
		4'b0000: begin
		       	 	alu_ctrl = {1'b0,1'b1,func};	
		       	 end
		//I-type arithmetic instr
		4'b1000: begin
		       	 	alu_ctrl = {1'b0,1'b1,func_imm_lw};	
		       	 end
		//Load instr
		4'b1001: begin
		       	 	alu_ctrl = {1'b0,1'b1,func_imm_lw};	
		       	 end
		//Store instr
		4'b0101: begin
		       	 	alu_ctrl = {1'b0,1'b1,func_br_sw};	
		       	 end
		//Jump instr
		4'b1011: begin
				alu_ctrl = {1'b0,1'b1,func_imm_lw};
			 end
		//R-type comp instr
		4'b0010: begin
		       	 	alu_ctrl = {1'b0,1'b0,func};	
		       	 end
		//I-type comp instr
		4'b1010: begin
		       	 	alu_ctrl = {1'b0,1'b0,func_imm_lw};	
		       	 end
		//Branch instr
		4'b0110: begin
				alu_ctrl = {1'b1,1'b1,func_br_sw};
			 end

	endcase	
end
endmodule