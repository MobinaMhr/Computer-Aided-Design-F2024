library verilog;
use verilog.vl_types.all;
entity Done_checker is
    port(
        input1          : in     vl_logic;
        input2          : in     vl_logic;
        input3          : in     vl_logic;
        input4          : in     vl_logic;
        done_signal     : out    vl_logic
    );
end Done_checker;
