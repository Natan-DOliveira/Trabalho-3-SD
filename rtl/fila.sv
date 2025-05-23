module fila 
(#parameter CLOCK_10KHz = 10000)
(
    input logic reset,
    input logic data_in,
    input logic dequeue_in,
    input logic enqueue_in,

    output logic len_out,
    output logic data_out
);
