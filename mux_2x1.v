module mux_2x1(
    input [31:0] I1,
    input [31:0] I2,
    input sel,
    output reg [31:0] out
    );
always @(sel or I1 or I2)
begin
	 case(sel)
	 1'b0:	begin	out=I1;	 	end
	 1'b1:	begin	out=I2;	 	end
	 endcase
end

endmodule

