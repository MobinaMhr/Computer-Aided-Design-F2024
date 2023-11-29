library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        done            : in     vl_logic;
        start           : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        load_x          : out    vl_logic;
        load_t          : out    vl_logic;
        select_t        : out    vl_logic
    );
end controller;
