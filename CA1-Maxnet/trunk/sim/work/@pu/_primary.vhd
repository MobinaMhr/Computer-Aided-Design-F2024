library verilog;
use verilog.vl_types.all;
entity Pu is
    port(
        input1          : in     vl_logic_vector(31 downto 0);
        input2          : in     vl_logic_vector(31 downto 0);
        input3          : in     vl_logic_vector(31 downto 0);
        input4          : in     vl_logic_vector(31 downto 0);
        weight1         : in     vl_logic_vector(31 downto 0);
        weight2         : in     vl_logic_vector(31 downto 0);
        weight3         : in     vl_logic_vector(31 downto 0);
        weight4         : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        o_result        : out    vl_logic_vector(31 downto 0)
    );
end Pu;
