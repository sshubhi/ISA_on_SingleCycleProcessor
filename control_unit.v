module control_unit (
input [3:0] opcode,
output reg jump,
output reg branch,
output reg mem_read,
output reg mem_to_reg,
output reg mem_write,
output reg alu_src,
output reg reg_write
); 

always @ (*)
begin
	case (opcode)
	//R-Type arithmetic instr
	4'b0000:  begin
			// reg_dst = 1'b1;
			reg_write = 1'b1;
			alu_src = 1'b0;
			mem_to_reg = 1'b0;
		  end
	//I-Type arithmetic instr
	4'b1000:  begin
			// reg_dst = 1'b1;
			reg_write = 1'b1;
			alu_src = 1'b1;
			mem_to_reg = 1'b0;
			jump = 1'b0;
		  end
	//Load instr
	4'b1001:  begin
			mem_read = 1'b1;		
			mem_to_reg = 1'b1;	
			jump = 1'b0;
			alu_src = 1'b1;
			mem_write = 1'b0;
		  end
	//Store instr
	4'b0101:  begin
			mem_write = 1'b1;
			alu_src = 1'b1;
			jump = 1'b0;
			mem_read = 1'b0;
		  end
	//R-Type Comp instr
	4'b0010:  begin
			reg_write = 1'b1;
			alu_src = 1'b0;
			mem_to_reg = 1'b0;
		  end
	//I-type Comp instr
	4'b1010:  begin
			reg_write = 1'b1;
			alu_src = 1'b1;
			mem_to_reg = 1'b0;
			jump = 1'b0;
		  end
	//Branch instr
	4'b0110:  begin
			alu_src = 1'b0;
			branch = 1'b1;
			jump = 1'b0;
		  end 
	//JAL instr
	4'b1011:  begin
			alu_src = 1'b1;
			jump = 1'b1;
			branch = 1'b0;
			reg_write = 1'b1;
		  end

	endcase
end
endmodule
