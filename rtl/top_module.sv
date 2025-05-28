module top_module
(
    input logic clock_1MHz,
    input logic reset,
    input logic data_in,
    input logic write_in,
    input logic dequeue_in

    output logic status_out,
    output logic data_ready,
    output logic [7:0] data_out,
    output logic [7:0] len_out
);    


endmodule
