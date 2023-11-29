library verilog;
use verilog.vl_types.all;
entity Adder is
    generic(
        N               : integer := 32
    );
    port(
        i_operand1      : in     vl_logic_vector;
        i_operand2      : in     vl_logic_vector;
        o_result        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end Adder;
