module fila 
(#parameter CLOCK_10KHz = )
(
    input logic clock,
    input logic reset,
    input logic dequeue_in,
    input logic enqueue_in,
    input logic[7:0] data_in,

    output logic[7:0] len_out,
    output logic[7:0] data_out
);

    typedef enum logic[2:0] 
    {
        temp1 = 3'b000,
        temp2 = 3'b001,
        temp3 = 3'b010,
        temp4 = 3'b011,
    } state_t;
