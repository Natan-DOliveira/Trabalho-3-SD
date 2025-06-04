if {[file isdirectory work]} {vdel -all -lib work}
vlib work
vmap work work

vlog -work work ../../rtl/top_module.sv
vlog -work work ../../rtl/deserializador.sv
vlog -work work ../../rtl/fila.sv
vlog -work work tb_top_module.sv
vsim -voptargs=+acc work.tb_top_module

quietly set StdArithNoWarnings 1
quietly set StdVitalGlitchNoWarnings 1

do wave.do
run 1000ns