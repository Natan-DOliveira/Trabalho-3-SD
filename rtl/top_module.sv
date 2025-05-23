module top_module
(
    input logic reset,
    input logic data_in,
    input logic data_ready,
    input logic ack_in,
    input logic write_in,
    input logic data_in,

    output logic status_out,
    output logic [7:0] data_out,
    output logic data_ready,
    output logic [7:0] len_out
);    

    deserializador DUT_deserializador 
    (
        .clock(clock),
        .reset(reset),
        .ack_in(ack_in),
        .data_in(data_in),
        .write_in(write_in),
        .data_out(data_out),
        .data_ready(data_ready),
        .status_out(status_out)
    );

    fila DUT_fila
    (
        .clock(clock),
        .reset(reset),
        .len_out(len_out),
        .data_in(data_in),
        .data_out(data_out),
        .enqueue_in(enqueue_in),
        .dequeue_out(dequeue_out)
    );

endmodule
