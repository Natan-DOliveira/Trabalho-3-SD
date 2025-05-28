if {[file isdirectory work]} {vdel -all -lib work}
vlib work
vmap work work

vlog -work work ../../rtl/deserializador.sv
vlog -work work tb_deserializador.sv
vsim -voptargs=+acc work.tb_deserializador

quietly set StdArithNoWarnings 1
quietly set StdVitalGlitchNoWarnings 1

do wave.do
run 630ns