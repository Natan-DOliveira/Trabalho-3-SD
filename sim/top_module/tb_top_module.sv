`timescale 1ns/1ps

module tb_top_module;
    
    logic clock_1MHz;
    logic reset;
    logic data_in;
    logic write_in;
    logic dequeue_in;
    logic status_out;
    logic [7:0] data_out;
    logic [7:0] len_out;

    top_module DUT_TOP_MODULE 
    (
        .clock_1MHz(clock_1MHz),
        .reset(reset),
        .data_in(data_in),
        .len_out(len_out),
        .data_out(data_out),
        .write_in(write_in),
        .dequeue_in(dequeue_in),
        .status_out(status_out)
    );

    always #0.5 clock_1MHz = ~clock_1MHz;

    initial begin
        $monitor("Time=%0t state=%s len_out=%0d data_out=%8b status_out=%b",
                 $time, DUT_TOP_MODULE.deserializer.state.name, len_out, data_out, status_out);

        clock_1MHz = 0;
        reset      = 1;
        data_in    = 0;
        write_in   = 0; 
        dequeue_in = 0;  #10; 
        reset      = 0;  #10;

            // ENVIA: 55 | 170
        write_in   = 1; #10;
        data_in    = 1; #10; data_in = 0; #10; data_in = 1; #10; data_in = 0; #10;
        data_in    = 1; #10; data_in = 0; #10; data_in = 1; #10; data_in = 0; #10;
        write_in   = 0; #200;

            // LIMPA e ENVIA: 2d | 45 --> ENVIA: 5f | 95
        reset      = 1; #10; reset   = 0; #10;
        write_in   = 1;
        data_in    = 0; #10; data_in = 0; #10; data_in = 1; #10; data_in = 0; #10;
        data_in    = 1; #10; data_in = 1; #10; data_in = 0; #10; data_in = 1; #10;
        write_in   = 0; #10;
        write_in   = 1; #10;
        data_in    = 1; #10; data_in = 0; #10; data_in = 1; #10; data_in = 1; #10;
        data_in    = 1; #10; data_in = 1; #10; data_in = 1; #10; data_in = 1; #10;
        write_in   = 0; #10;

            // REMOVE UM ELEMENTO DA FILA
        dequeue_in = 1; #10; 
        dequeue_in = 0; #10;
    end
endmodule