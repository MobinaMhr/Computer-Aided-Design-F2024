	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"Maxnet_NN_tb"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
	# set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Activation_function.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Adder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Bitwise_or.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Buffer.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Controler.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Done_checker.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Encoder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Memory.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Multiplier.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux_four_to_one.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux_two_to_one.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PU.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Register_32_bit_without_en.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Register_32_bit.v
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