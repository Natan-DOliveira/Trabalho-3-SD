module deserializador 
#(parameter CLOCK_100KHz = 1000)
    input logic reset,
    input logic data_in,
    input logic write_in,
    input logic ack_in,
    
    output logic status_out,
    output logic data_ready,
    output logic [7:0] data_out,
);
