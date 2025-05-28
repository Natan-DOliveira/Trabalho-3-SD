module fila (
    input logic clock_10KHz,
    input logic reset,
    input logic dequeue_in,
    input logic enqueue_in,
    input logic [7:0] data_in,

    output logic [7:0] len_out,
    output logic [7:0] data_out
);

    typedef enum logic [1:0] 
    {
        temp1 = 2'b00,
        temp2 = 2'b01,
        temp3 = 2'b10,
        temp4 = 2'b11,
    } state_t;



endmodule