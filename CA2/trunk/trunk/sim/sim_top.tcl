	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Actel_C1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Actel_C2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Actel_S1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Actel_S2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Activation_function.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Adder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/And3.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/And4.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/BitMultiplier.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Buffer.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Convert_to_twosComp.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/C_AND.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/C_OR.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/C_XOR.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Data_path.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DoneChecker.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Encoder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Five_bit_or.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Full_Adder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Multiplier.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Not.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/N_bit_four_to_one_mux.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/N_bit_two_to_one_mux.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/One_bit_four_to_one_mux.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/One_bit_two_to_one_mux.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR3.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR4.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PU.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Register.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Top_module.v
		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	