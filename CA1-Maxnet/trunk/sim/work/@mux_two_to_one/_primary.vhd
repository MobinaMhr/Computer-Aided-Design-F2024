library verilog;
use verilog.vl_types.all;
entity Mux_two_to_one is
    port(
        input_1         : in     vl_logic_vector(31 downto 0);
        input_2         : in     vl_logic_vector(31 downto 0);
        \select\        : in     vl_logic;
        mux_output      : out    vl_logic_vector(31 downto 0)
    );
end Mux_two_to_one;
