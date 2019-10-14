module data_memory (
input reset,
input [31:0] addr,
input [31:0] wr_data,
input mem_rd,
input mem_wr,
output reg [31:0] rd_data
);

reg [31:0] data_mem [49:0];

always @ (negedge reset)
begin
	$readmemh("data_memory.mem",data_mem);
end

always @ (*)
begin

	if ((reset == 0) & (mem_wr == 1'b1)) begin
		data_mem[addr] = wr_data;
	end
	else if ((reset == 0) & (mem_rd == 1'b1)) begin
 		rd_data = data_mem[addr];
	end
end
endmodule



