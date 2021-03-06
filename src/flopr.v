module flopr(clk, sig, d, q);
    parameter width=32;
    input clk;
    input sig;
    input [width-1:0] d;
    output reg [width-1:0] q;

    always @(negedge clk)
        if (sig==1)
            q <= d;
endmodule