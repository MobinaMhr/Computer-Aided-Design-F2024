library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ld_t            : in     vl_logic;
        ld_x            : in     vl_logic;
        sel_t           : in     vl_logic;
        maximum_number  : out    vl_logic_vector(31 downto 0);
        done            : out    vl_logic
    );
end datapath;
