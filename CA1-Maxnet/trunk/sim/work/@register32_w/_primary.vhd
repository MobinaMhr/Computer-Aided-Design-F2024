library verilog;
use verilog.vl_types.all;
entity Register32_w is
    port(
        input_data      : in     vl_logic_vector(31 downto 0);
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        output_data     : out    vl_logic_vector(31 downto 0)
    );
end Register32_w;
