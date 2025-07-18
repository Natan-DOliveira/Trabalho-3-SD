onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_fila/clock_10KHz
add wave -noupdate /tb_fila/reset
add wave -noupdate /tb_fila/DUT_FILA/state
add wave -noupdate /tb_fila/enqueue_in
add wave -noupdate /tb_fila/dequeue_in
add wave -noupdate /tb_fila/DUT_FILA/len_out
add wave -noupdate /tb_fila/DUT_FILA/fila
add wave -noupdate /tb_fila/DUT_FILA/head_node
add wave -noupdate /tb_fila/DUT_FILA/tail_node
add wave -noupdate /tb_fila/data_in
add wave -noupdate /tb_fila/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {917 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 126
configure wave -valuecolwidth 85
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {11941 ns}