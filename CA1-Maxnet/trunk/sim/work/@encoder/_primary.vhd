library verilog;
use verilog.vl_types.all;
entity Encoder is
    port(
        input_1         : in     vl_logic;
        input_2         : in     vl_logic;
        input_3         : in     vl_logic;
        input_4         : in     vl_logic;
        encoded_output  : out    vl_logic_vector(1 downto 0)
    );
end Encoder;
