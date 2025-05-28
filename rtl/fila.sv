module fila (
    input logic clock_10KHz,
    input logic reset,
    input logic dequeue_in,
    input logic enqueue_in,
    input logic [7:0] data_in,

    output logic [7:0] len_out,
    output logic [7:0] data_out
);

        // FSM
    typedef enum logic [1:0] 
    {
        AGUARDA = 2'b00,
        RECEBE  = 2'b01,
        PRONTO  = 2'b10,
        ESPERA  = 2'b11
    } state_t;

        // Registradores
    state_t state;
    logic [2:0] head_node;    
    logic [2:0] tail_node;
    logic [7:0] [7:0] fila;

        // Lógica Síncrona
    always @(posedge clock_10KHz or posedge reset) begin
        if (reset) begin
            state     <= AGUARDA;
            head_node <= 1'b0;
            tail_node <= 1'b0;
            len_out   <= 8'b0;
            data_out  <= 8'b0;
        end
        else begin
            case (state)
                
                AGUARDA: begin
                    if (enqueue_in) begin
                        state <= RECEBE;
                    end
                end

                RECEBE: begin

                end

                PRONTO: begin

                end

                ESPERA: begin

                end
            endcase
        end
    end
endmodule