module uart (
    input wire clk,
    input wire rst,
    input wire rx,
    output wire tx,
    output reg [7:0] received_data,
    input wire [7:0] send_data,
    input wire send_data_valid,
    output reg send_data_ready
);
    parameter BAUD_RATE = 9600;
    parameter CLOCK_FREQ = 100000000;
    parameter BAUD_DIV = CLOCK_FREQ / BAUD_RATE;

    // UART Receiver Signals
    reg [3:0] rx_state;
    reg [15:0] rx_counter;
    reg [7:0] rx_shift_reg;
    reg [2:0] rx_bit_count;
    reg rx_busy;

    // UART Transmitter Signals
    reg [3:0] tx_state;
    reg [15:0] tx_counter;
    reg [7:0] tx_shift_reg;
    reg [2:0] tx_bit_count;
    reg tx_busy;

    // Receiver State Machine
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_state <= 0;
            rx_counter <= 0;
            rx_shift_reg <= 0;
            rx_bit_count <= 0;
            rx_busy <= 0;
        end else begin
            case (rx_state)
                0: begin // Idle state
                    if (!rx) begin
                        rx_state <= 1;
                        rx_counter <= 0;
                        rx_busy <= 1;
                    end
                end
                1: begin // Start bit detection
                    if (rx_counter == (BAUD_DIV / 2)) begin
                        if (!rx) begin
                            rx_state <= 2;
                            rx_counter <= 0;
                            rx_bit_count <= 0;
                        end else begin
                            rx_state <= 0;
                            rx_busy <= 0;
                        end
                    end else begin
                        rx_counter <= rx_counter + 1;
                    end
                end
                2: begin // Data bit reception
                    if (rx_counter == BAUD_DIV) begin
                        rx_counter <= 0;
                        rx_shift_reg <= {rx, rx_shift_reg[7:1]};
                        if (rx_bit_count == 7) begin
                            rx_state <= 3;
                        end else begin
                            rx_bit_count <= rx_bit_count + 1;
                        end
                    end else begin
                        rx_counter <= rx_counter + 1;
                    end
                end
                3: begin // Stop bit detection
                    if (rx_counter == BAUD_DIV) begin
                        rx_state <= 0;
                        rx_busy <= 0;
                        received_data <= rx_shift_reg;
                    end else begin
                        rx_counter <= rx_counter + 1;
                    end
                end
            endcase
        end
    end

    // Transmitter State Machine
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_state <= 0;
            tx_counter <= 0;
            tx_shift_reg <= 0;
            tx_bit_count <= 0;
            tx_busy <= 0;
        end else begin
            case (tx_state)
                0: begin // Idle state
                    if (send_data_valid) begin
                        tx_state <= 1;
                        tx_shift_reg <= send_data;
                        tx_counter <= 0;
                        tx_bit_count <= 0;
                        tx_busy <= 1;
                    end
                end
                1: begin // Start bit transmission
                    if (tx_counter == BAUD_DIV) begin
                        tx_counter <= 0;
                        tx_state <= 2;
                    end else begin
                        tx_counter <= tx_counter + 1;
                    end
                end
                2: begin // Data bit transmission
                    if (tx_counter == BAUD_DIV) begin
                        tx_counter <= 0;
                        if (tx_bit_count == 7) begin
                            tx_state <= 3;
                        end else begin
                            tx_bit_count <= tx_bit_count + 1;
                            tx_shift_reg <= {1'b0, tx_shift_reg[7:1]};
                        end
                    end else begin
                        tx_counter <= tx_counter + 1;
                    end
                end
                3: begin // Stop bit transmission
                    if (tx_counter == BAUD_DIV) begin
                        tx_state <= 0;
                        tx_busy <= 0;
                    end else begin
                        tx_counter <= tx_counter + 1;
                    end
                end
            endcase
        end
    end

    // Assigning tx line
    assign tx = (tx_state == 0) ? 1'b1 : 
                (tx_state == 1) ? 1'b0 : 
                (tx_state == 2) ? tx_shift_reg[0] : 1'b1;

    // Send data ready signal
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            send_data_ready <= 0;
        end else if (tx_state == 0 && !tx_busy) begin
            send_data_ready <= 1;
        end else begin
            send_data_ready <= 0;
        end
    end
endmodule