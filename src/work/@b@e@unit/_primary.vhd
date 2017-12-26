library verilog;
use verilog.vl_types.all;
entity BEUnit is
    port(
        addr            : in     vl_logic_vector(1 downto 0);
        instr           : in     vl_logic_vector(5 downto 0);
        beout           : out    vl_logic_vector(3 downto 0)
    );
end BEUnit;
