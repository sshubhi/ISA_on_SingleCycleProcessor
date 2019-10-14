module instruction_memory (
input [31:0] PC,
input reset,
output [31:0] instruction
);

// Make word addressable instead? Currrent size is 64 instructions
reg [7:0] instr_mem [255:0];

assign instruction = {instr_mem[PC], instr_mem[PC+1], instr_mem[PC+2], instr_mem[PC+3]};

always @ (reset)
begin
	if (reset == 0) begin
		$readmemh("instruction.mem",instr_mem);
	end
end
endmodule

