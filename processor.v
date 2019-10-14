module processor (
input clk,
input reset
);

wire [31:0] instr;
wire [31:0] rd_data_1;
wire [31:0] rd_data_2;
wire [31:0] alu_in;
wire alu_zero;
wire [31:0] alu_result;
wire [31:0] mem_rd_data;
wire [31:0] reg_wr_data;
wire [31:0] alu_mem_wr_data;
wire [5:0] alu_ctrl_out;
wire [31:0] sxt_out;
wire [31:0] sxt_alu_in;
wire [31:0] jump_regdst_val;
wire jump_cs;
wire branch_cs;
wire mem_read_cs;
wire mem_to_reg_cs;
wire mem_write_cs;
wire alu_src_cs;
wire reg_write_cs;

instruction_fetch IF (clk,reset,branch_cs,jump_cs,alu_zero,alu_result,sxt_out,jump_regdst_val,instr);
control_unit ctrl_unit (instr[31:28],jump_cs,branch_cs,mem_read_cs,mem_to_reg_cs,mem_write_cs,alu_src_cs,reg_write_cs);
register_file reg_file (reset,instr[23:20],instr[19:16],instr[27:24],reg_wr_data,reg_write_cs,rd_data_1,rd_data_2);
mux_2x1 MUX_1 (rd_data_2,sxt_alu_in,alu_src_cs,alu_in);
sign_extend SXT_1 (instr[15:0],sxt_out);
mux_2x1 MUX_2 (sxt_out,(sxt_out<<2),jump_cs,sxt_alu_in);
alu_control ALU_ctrl (instr[31:28],instr[3:0],instr[19:16], instr[27:24], alu_ctrl_out);
alu ALU_unit (rd_data_1,alu_in,alu_ctrl_out,alu_zero,alu_result);
data_memory data_mem (reset,alu_result,rd_data_2,mem_read_cs,mem_write_cs,mem_rd_data);
mux_2x1 MUX_3 (alu_result,mem_rd_data,mem_to_reg_cs,alu_mem_wr_data);
mux_2x1 MUX_4 (alu_mem_wr_data,jump_regdst_val,jump_cs,reg_wr_data);
endmodule
