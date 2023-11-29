library verilog;
use verilog.vl_types.all;
entity Multiplier is
    generic(
        N               : integer := 32
    );
    port(
        input1          : in     vl_logic_vector;
        input2          : in     vl_logic_vector;
        o_result        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end Multiplier;
