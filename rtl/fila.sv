module fila (
    input logic clock_10KHz,
    input logic reset,
    input logic enqueue_in,
    input logic dequeue_in,
    input logic [7:0] data_in,

    output logic [7:0] len_out,
    output logic [7:0] data_out
);

        // FSM
    typedef enum logic [1:0] 
    {
        AGUARDA = 2'b00,                        // AGUARDA o enqueue_in/dequeue_in alto
        ENQUEUE = 2'b01,                        // ENQUEUE: coloca um número de 8 bits na fila
        DEQUEUE = 2'b10                         // DEQUEUE: remove o primeiro elemento da fila e um ciclo depois coloca no data_out
    } state_t;

        // Registradores
    state_t state;
    logic [2:0] head_node;
    logic [2:0] tail_node;
    logic [7:0] reg_len_out;
    logic [7:0] fila [7:0] ;

    assign len_out = reg_len_out;

        // Lógica Síncrona
    always_ff @(posedge clock_10KHz or posedge reset) begin
        if (reset) begin
            state       <= AGUARDA;
            head_node   <= 1'b0;
            tail_node   <= 1'b0;
            reg_len_out <= 8'b0;
            data_out    <= 8'b0;
            for (int i = 0; i < 8; i++) begin
                fila[i] <= 8'hZZ;
            end
        end
        else begin
            case (state)
                
                AGUARDA: begin
                    if (enqueue_in && reg_len_out < 8) begin
                        state <= ENQUEUE;
                    end
                    else if (dequeue_in && reg_len_out > 0) begin
                        state <= DEQUEUE;
                    end
                end

                ENQUEUE: begin
                    fila[tail_node] <= data_in;
                    tail_node       <= tail_node + 1;
                    reg_len_out     <= reg_len_out + 1;
                    state           <= AGUARDA;
                end

                DEQUEUE: begin
                    data_out                <= fila[head_node];
                    fila[head_node]         <= 8'hZZ;
                    head_node               <= head_node + 1;
                    reg_len_out             <= reg_len_out - 1;
                    state                   <= AGUARDA;
                end
            endcase
        end
    end
endmodule
