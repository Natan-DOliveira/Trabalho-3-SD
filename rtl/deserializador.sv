module deserializador (
    input logic clock_100KHz,
    input logic reset,
    input logic ack_in,
    input logic data_in,
    input logic write_in,
    
    output logic status_out,
    output logic data_ready,
    output logic [7:0] data_out
);

        // FSM
    typedef enum logic [1:0]
    {
        AGUARDA = 2'b00,                    // AGUARDA o write_in alto
        RECEBE  = 2'b01,                    // RECEBE os bits e acumula eles até chegar em 8
        PRONTO  = 2'b10,                    // PRONTO quando receber os 8 bits --> status_out alto
        ESPERA  = 2'b11                     // ESPERA o ack_in alto
    } state_t;

        // Registradores
    state_t state;   
    logic [2:0] bits_count;
    logic [7:0] bits_storage;

        // Lógica Síncrona
    always_ff @(posedge clock_100KHz or posedge reset) begin
        if (reset) begin
            state        <= AGUARDA;
            status_out   <= 1'b0;
            data_ready   <= 1'b0;
            bits_count   <= 3'b0;
            bits_storage <= 8'b0;
            data_out     <= 8'b0;
        end
        else begin
            case (state)

                AGUARDA: begin
                    if (write_in) begin
                        state <= RECEBE;
                    end
                end

                RECEBE: begin
                    if (bits_count <= 7 && write_in) begin
                        bits_storage[bits_count] <= data_in;
                        bits_count <= bits_count + 1'b1;
                        if (bits_count == 7) begin
                            state  <= PRONTO;
                        end
                    end
                    else begin
                        state <= AGUARDA;
                    end
                end

                PRONTO: begin
                    data_out   <= bits_storage;
                    data_ready <= 1'b1;
                    status_out <= 1'b1;         // OCUPADO
                    bits_count <= 3'b0;
                    state      <= ESPERA;
                end

                ESPERA: begin
                    if (ack_in) begin
                        state      <= AGUARDA;
                        data_ready <= 1'b0;
                        status_out <= 1'b0;
                    end
                end
            endcase
        end
    end
endmodule