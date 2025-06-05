`timescale 1ns/1ps

module tb_top_module;
    logic clock_1MHz;
    logic reset;
    logic data_in; 
    logic write_in; 
    logic dequeue_in;
    logic status_out;
    logic [7:0] len_out;
    logic [7:0] data_out;

    top_module DUT_TOP_MODULE
    (
        .clock_1MHz(clock_1MHz),
        .reset(reset),
        .data_in(data_in),
        .write_in(write_in),
        .dequeue_in(dequeue_in),
        .status_out(status_out),
        .data_out(data_out),
        .len_out(len_out)
    );

    always #0.5 clock_1MHz = ~clock_1MHz;

    initial begin

        $monitor("Time=%0t deser_state=%s queue_state=%s len_out=%0d data_out=%8b status_out=%b data_ready=%b enqueue_in=%b ack_in=%b sincroniza_data_ready=%2b sincroniza_ack_in=%2b bits_count=%0d bits_storage=%8b head=%0d tail=%0d",
                 $time, 
                 DUT_TOP_MODULE.deserializer.state.name, 
                 DUT_TOP_MODULE.queue.state.name, 
                 len_out, 
                 data_out, 
                 status_out, 
                 DUT_TOP_MODULE.deserializador_data_ready, 
                 DUT_TOP_MODULE.enqueue_in, 
                 DUT_TOP_MODULE.deserializador_ack_in, 
                 DUT_TOP_MODULE.sincroniza_data_ready, 
                 DUT_TOP_MODULE.sincroniza_ack_in, 
                 DUT_TOP_MODULE.deserializer.bits_count, 
                 DUT_TOP_MODULE.deserializer.bits_storage, 
                 DUT_TOP_MODULE.queue.head_node, 
                 DUT_TOP_MODULE.queue.tail_node);

        clock_1MHz = 0;
        reset      = 1;
        data_in    = 0;
        write_in   = 0;
        dequeue_in = 0;
        #10 reset  = 0; #10;

            // Teste 1: Caso Bom
        $display("\n--- Teste 1: Caso Bom - Insercao e remocao sem travamento ---");
        // Enviar 0xAA e remover um byte
        write_in = 1; #10;
        data_in  = 0; #10; data_in = 1; #10; data_in = 0; #10; data_in = 1; #10;
        data_in  = 0; #10; data_in = 1; #10; data_in = 0; #10; data_in = 1; #10; // 0xAA
        write_in = 0; #600;
        dequeue_in = 1; #100; dequeue_in = 0; #200;
        // Enviar 0x55 e remover um byte
        write_in = 1; #10;
        data_in  = 1; #10; data_in = 0; #10; data_in = 1; #10; data_in = 0; #10;
        data_in  = 1; #10; data_in = 0; #10; data_in = 1; #10; data_in = 0; #10; // 0x55
        write_in = 0; #600;
        dequeue_in = 1; #100; dequeue_in = 0; #200;
        if (len_out <= 7 && status_out == 0)
            $display("Teste 1 OK: len_out=%0d, status_out=%b (sem travamento)", len_out, status_out);
        else
            $display("Teste 1 FALHOU: len_out=%0d, status_out=%b", len_out, status_out);
        
            // Teste 2: Caso Ruim
        $display("\n--- Teste 2: Caso Ruim - Encher fila com 8 bytes ---");
        #20 reset  = 1; reset  = 0; #20;
        for (int i = 0; i < 8; i++) begin
            write_in = 1; #10;
            data_in  = 1; #10; data_in = 1; #10; data_in = 1; #10; data_in = 1; #10;
            data_in  = 1; #10; data_in = 1; #10; data_in = 1; #10; data_in = 1; #10; // 0xFF
            write_in = 0; #600;
        end
        write_in = 1; #10;
        data_in  = 0; #10; data_in = 0; #10; data_in = 0; #10; data_in = 0; #10;
        data_in  = 0; #10; data_in = 0; #10; data_in = 0; #10; data_in = 0; #10; // 0x00
        write_in = 0; #600;
        if (len_out == 8 && status_out == 1)
            $display("Teste 2 OK: Fila cheia (len_out=%0d), deserializador travado (status_out=%b)", len_out, status_out);
        else
            $display("Teste 2 FALHOU: len_out=%0d, status_out=%b", len_out, status_out);
    end
endmodule