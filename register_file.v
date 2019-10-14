module register_file (
input rst,
input [3:0] rd_reg1,
input [3:0] rd_reg2,
input [3:0] wr_reg,
input [31:0] wr_data,
input reg_write,
output [31:0] rd_data1,
output [31:0] rd_data2
);

reg [31:0] reg_file [31:0];

assign rd_data1 = reg_file[rd_reg1];
assign rd_data2 = reg_file[rd_reg2];

always @ (negedge rst) begin
	$readmemh("register_file.mem",reg_file);
end

always @ (*)
begin
	if ((rst == 0) & (reg_write == 1)) begin
		reg_file[wr_reg] = wr_data;
	end
end

endmodule
