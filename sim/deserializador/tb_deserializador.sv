`timescale 1ps/1ns

module tb_deserializador;

    logic clock_100KHz;
    logic reset;
    logic ack_in;
    logic data_in;
    logic write_in;
    logic status_out;
    logic data_ready;
    logic [7:0] data_out;

    deserializador DUT 
    (
        .clock_100KHz(clock_100KHz),
        .reset(reset),
        .ack_in(ack_in),
        .data_in(data_in),
        .write_in(write_in),
        .status_out(status_out),
        .data_ready(data_ready),
        .data_out(data_out)
    );

    always #5 clock_100KHz = ~clock_100KHz;

    initial begin

        $monitor("Time=%0t state=%s data_in=%b write_in=%b bits_count=%0d data_out=%8b data_ready=%b status_out=%b",
                 $time, dut.state.name, data_in, write_in, dut.bits_count, data_out, data_ready, status_out);

        clock_100KHz = 0;
        reset    = 1;
        ack_in   = 0;
        data_in  = 0;
        write_in = 0; #10;
        reset    = 0; #10;
        write_in = 1;
        data_in  = 0; #10;
        data_in  = 1; #10;
        data_in  = 0; #10;
        write_in = 0; #10;
        data_in  = 1; #10;
        write_in = 1;
        data_in  = 1; #10;
        data_in  = 0; #10;
        data_in  = 1; #10;
        data_in  = 0; #10;
        data_in  = 1; #10;
        write_in = 0; #10;
        ack_in   = 1; #20;
        ack_in   = 0; #10;
    end
endmodule