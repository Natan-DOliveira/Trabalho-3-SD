`timescale 1ns/1ps

module tb_fila;

    logic clock_10KHz;
    logic reset;
    logic enqueue_in;
    logic dequeue_in;
    logic [7:0] data_in;
    logic [7:0] len_out;
    logic [7:0] data_out;

    fila DUT_FILA
    (
        .clock_10KHz(clock_10KHz),
        .reset(reset),
        .data_in(data_in),
        .len_out(len_out),
        .data_out(data_out),
        .enqueue_in(enqueue_in),
        .dequeue_in(dequeue_in)
    );

    always #5 clock_10KHz = ~clock_10KHz;

    initial begin
        $monitor("Time=%0t state=%s enqueue_in=%b dequeue_in=%b head_node=%0d tail_node=%0d data_in=%8b data_out=%8b fila=%0d len_out",
                 $time, DUT_FILA.state.name, enqueue_in, dequeue_in, DUT_FILA.head_node, DUT_FILA.tail_node, data_in, data_out, DUT_FILA.fila, DUT_FILA.len_out);

        clock_10KHz = 0;
        reset       = 1;
        enqueue_in  = 0;
        dequeue_in  = 0;
        data_in     = 8'b0; #10;
        reset       = 0;    #10;

            // Teste 1: Adicionar mais de 8 elementos na fila 
        enqueue_in = 1;
        for (int i = 0; i <= 10; i++) begin
                // Teste para ver se adiciona na fila com o enqueue_in baixo
            if (i == 4) begin
                enqueue_in = 0; #5;
            end 
            else begin
                data_in = 8'b0 + i;
                enqueue_in = 1; #10;
            end
        end
        enqueue_in = 0;

            // Teste 2: Remover todos os elementos e ver se é possível remover mesmo vazio
        dequeue_in = 1;
        for (int i = 10; i >= 0; i--) begin
            #10;
        end
    end
endmodule