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
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Adder.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Address_generator.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/CNN.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Controller.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Corr_calculator.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Datapath.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Done_checker_counter.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Filter_buffer.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Filter_memory.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/First_layer.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/FL_OFM_mux.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Four_bit_counter.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mac.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mac_out_adder.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Main_buffer.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Main_buffer_load_counter.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Multiplier.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OFM_memory.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Parametrized_counter.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PC.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PE.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Read_memory.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Register.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Second_layer.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Shift_register.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/SL_Controller.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/SL_Datapath.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/SL_PE.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Two_bit_counter.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Two_to_one_mux.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Up_12_counter.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Window_buffer.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Write_memory.sv
		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.sv
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
	