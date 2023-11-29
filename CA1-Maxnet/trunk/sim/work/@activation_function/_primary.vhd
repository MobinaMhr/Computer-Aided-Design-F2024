library verilog;
use verilog.vl_types.all;
entity Activation_function is
    port(
        ac_in1          : in     vl_logic_vector(31 downto 0);
        ac_in2          : in     vl_logic_vector(31 downto 0);
        \select\        : in     vl_logic;
        ac_out          : out    vl_logic_vector(31 downto 0)
    );
end Activation_function;
