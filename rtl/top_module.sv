module top_module
#(parameter HALF_100KHZ_COUNT = 5,              // (1MHz / 100KHz = 10 --> 5 ciclos)
  parameter HALF_10KHZ_COUNT  = 50)             // (1MHz / 10KHz = 100 -> 50 ciclos)
(
    input logic clock_1MHz,
    input logic reset,
    input logic data_in,
    input logic write_in,
    input logic dequeue_in,

    output logic status_out,
    output logic [7:0] len_out,
    output logic [7:0] data_out
);

        // Sinais Internos
    // CLOCKS
    logic clock_10KHz;
    logic clock_100KHz;
    logic [2:0] count_100KHz;                   // Contador de 0 até  4 p/ 100KHz
    logic [5:0] count_10KHz;                    // Contador de 0 até 49 p/ 10KHz
    // DESERIALIZADOR
    logic deserializador_ack_in;
    logic deserializador_status_out;
    logic deserializador_data_ready;
    logic [7:0] deserializador_data_out;
    // FILA
    logic enqueue_in;
    // SINCRONIZAÇÃO
    logic reg_ack_in;                           // ALTO quando fila acabou a operação
    logic [1:0] sincroniza_ack_in;              // Armazena estados do reg_ack_in em dois FF (10KHz --> 100KHz)
    logic [1:0] sincroniza_data_ready;          // Armazena estados do data_ready em dois FF (100KHz --> 10KHz)
    // ATRIBUIÇÕES COMBINACIONAIS
    assign status_out            = deserializador_status_out;
    assign enqueue_in            = sincroniza_data_ready[1];
    assign reg_ack_in            = deserializador_data_ready && (len_out < 8);
    assign deserializador_ack_in = sincroniza_ack_in[1];

        // Geração de Clock
    always_ff @(posedge clock_1MHz or posedge reset) begin
        if (reset) begin
            clock_10KHz  <= 1'b0;
            clock_100KHz <= 1'b0;
            count_100KHz <= 3'd0;
            count_10KHz  <= 6'd0;
        end
        else begin
                // Clock de 100KHz
            if (count_100KHz == HALF_100KHZ_COUNT - 1) begin
                clock_100KHz <= ~clock_100KHz;
                count_100KHz <= 3'd0;
            end
            else begin
                count_100KHz <= count_100KHz + 1;
            end
                // Clock de 10KHz
            if (count_10KHz == HALF_10KHZ_COUNT - 1) begin
                clock_10KHz <= ~clock_10KHz;
                count_10KHz <= 6'd0;
            end
            else begin
                count_10KHz <= count_10KHz + 1;
            end
        end
    end

        // Sincronização data_ready(100KHz --> 10KHz)
    always_ff @(posedge clock_100KHz or posedge reset) begin
        if (reset) begin
            sincroniza_data_ready <= 2'b0;
        end
        else begin
            sincroniza_data_ready <= {sincroniza_data_ready[0], deserializador_data_ready};
        end
    end

        // Sincronização ack_in(10KHz --> 100KHz)
    always_ff @(posedge clock_100KHz or posedge reset) begin
        if (reset) begin
            sincroniza_ack_in <= 2'b0;
        end
        else begin
            sincroniza_ack_in <= {sincroniza_ack_in[0], reg_ack_in};
        end
    end

    deserializador deserializer 
    (
        .clock_100KHz(clock_100KHz),
        .reset(reset),
        .data_in(data_in),
        .write_in(write_in),
        .ack_in(deserializador_ack_in),
        .data_out(deserializador_data_out),
        .data_ready(deserializador_data_ready),
        .status_out(deserializador_status_out)
    );

    fila queue
    (
        .clock_10KHz(clock_10KHz),
        .reset(reset),
        .len_out(len_out),
        .data_out(data_out),
        .dequeue_in(dequeue_in),
        .enqueue_in(enqueue_in),
        .data_in(deserializador_data_out)
    );
endmodule