library verilog;
use verilog.vl_types.all;
entity top_module is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        start_signal    : in     vl_logic;
        output_maximum_number: out    vl_logic_vector(31 downto 0);
        done            : out    vl_logic
    );
end top_module;
