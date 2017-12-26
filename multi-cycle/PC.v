module PCUnit(in,PC,clk,sig);
    output reg [31:0] PC;
    input [31:0] in;
    input clk;
    input sig;

    initial
    begin
        PC = 32'h0000_3000;
    end
    always@(negedge clk)
	begin
		if (sig)
            PC = in;
	end

endmodule