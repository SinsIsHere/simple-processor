onerror {exit -code 1}
vlib work
vlog -work work A_simple_processor_with_fucking_ROM_or_something.vo
vlog -work work Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate_ver -L altera_lnsim_ver work.A_simple_processor_with_fucking_ROM_or_something_vlg_vec_tst
vcd file -direction A_simple_processor_with_fucking_ROM_or_something.msim.vcd
vcd add -internal A_simple_processor_with_fucking_ROM_or_something_vlg_vec_tst/*
vcd add -internal A_simple_processor_with_fucking_ROM_or_something_vlg_vec_tst/i1/*
proc simTimestamp {} {
    echo "Simulation time: $::now ps"
    if { [string equal running [runStatus]] } {
        after 2500 simTimestamp
    }
}
after 2500 simTimestamp
run -all
quit -f


