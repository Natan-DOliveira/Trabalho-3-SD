onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top_module/clock_1MHz
add wave -noupdate /tb_top_module/reset
add wave -noupdate /tb_top_module/data_in
add wave -noupdate /tb_top_module/write_in
add wave -noupdate /tb_top_module/dequeue_in
add wave -noupdate /tb_top_module/len_out
add wave -noupdate /tb_top_module/data_out
add wave -noupdate /tb_top_module/status_out

add wave -noupdate /tb_top_module/DUT_TOP_MODULE/clock_100KHz
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/clock_10KHz
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/count_100KHz
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/count_10KHz
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/deserializador_ack_in
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/deserializador_data_ready
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/deserializador_data_out
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/enqueue_in
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/sincroniza_ack_in
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/sincroniza_data_ready

add wave -noupdate /tb_top_module/DUT_TOP_MODULE/deserializer/state
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/deserializer/bits_count
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/deserializer/bits_storage

add wave -noupdate /tb_top_module/DUT_TOP_MODULE/queue/state
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/queue/head_node
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/queue/tail_node
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/queue/len_out
add wave -noupdate /tb_top_module/DUT_TOP_MODULE/queue/fila

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