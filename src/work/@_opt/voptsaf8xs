library verilog;
use verilog.vl_types.all;
entity ctrl is
    port(
        clk             : in     vl_logic;
        instruction     : in     vl_logic_vector(31 downto 0);
        IRWr            : out    vl_logic;
        RegWAd          : out    vl_logic_vector(1 downto 0);
        DMWr            : out    vl_logic;
        PCWrite         : out    vl_logic;
        PCWriteCond     : out    vl_logic;
        PCSource        : out    vl_logic_vector(1 downto 0);
        ALUOp           : out    vl_logic_vector(3 downto 0);
        ALUSrcA         : out    vl_logic_vector(1 downto 0);
        ALUSrcB         : out    vl_logic_vector(2 downto 0);
        RFWr            : out    vl_logic;
        RegWDa          : out    vl_logic_vector(1 downto 0)
    );
end ctrl;
