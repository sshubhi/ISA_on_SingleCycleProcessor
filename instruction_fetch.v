module instruction_fetch (
input clk,
input rst,
input cs_branch,
input cs_jump,
input alu_zero,
input [31:0] jump_addr,
input [31:0] sxt_branch_addr,
output [31:0] jump_dst_reg_val,
output [31:0] instruction
);

reg [31:0]  PC;
instruction_memory IM (PC,rst,instruction);	

assign jump_dst_reg_val = PC + 4;

always @ (negedge rst) begin
	PC <= 32'b0;
end

always @(posedge clk)
begin
	if (cs_branch == 1'b1) begin
		PC <= (alu_zero==1) ? PC + 32'h4 + (sxt_branch_addr<<2) : PC + 32'h4;
	end
	else if (cs_jump == 1'b1) begin
		PC <= jump_addr;
	end
	else begin
		PC <= PC + 4;
	end
	
end
endmodule
