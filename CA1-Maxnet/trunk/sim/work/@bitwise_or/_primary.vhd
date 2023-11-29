library verilog;
use verilog.vl_types.all;
entity Bitwise_or is
    port(
        bitwise_input   : in     vl_logic_vector(31 downto 0);
        bitwise_output  : out    vl_logic
    );
end Bitwise_or;
