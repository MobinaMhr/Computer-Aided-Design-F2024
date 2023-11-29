library verilog;
use verilog.vl_types.all;
entity Memory is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        read_data1      : out    vl_logic_vector(31 downto 0);
        read_data2      : out    vl_logic_vector(31 downto 0);
        read_data3      : out    vl_logic_vector(31 downto 0);
        read_data4      : out    vl_logic_vector(31 downto 0)
    );
end Memory;
