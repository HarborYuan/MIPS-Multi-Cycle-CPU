library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        C               : out    vl_logic_vector(31 downto 0);
        Zero            : out    vl_logic;
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        ALUOp           : in     vl_logic_vector(3 downto 0);
        A_First         : out    vl_logic;
        A_Zero          : out    vl_logic
    );
end ALU;
