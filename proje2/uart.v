module uart (
    input wire clk,
    input wire rst,
    input wire rx,
    output wire tx,
    output reg [7:0] received_data,
    input wire [7:0] send_data,
    input wire send_data_valid,
    output reg send_data_ready,
    output reg received_data_ready
);
    parameter BAUD_RATE = 9600;
    parameter CLOCK_FREQ = 100000000;
    parameter BAUD_DIV = CLOCK_FREQ / BAUD_RATE;

    // UART Receiver Signals
    reg [3:0] rx_state;
    reg [15:0] rx_counter;
    reg [7:0] rx_shift_reg;
    reg rx_busy;

    // UART Transmitter Signals
    reg [3:0] tx_state;
    reg [15:0] tx_counter;
    reg [7:0] tx_shift_reg;
    reg tx_busy;

    // UART RX Logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_state <= 0;
            rx_counter <= 0;
            rx_shift_reg <= 0;
            rx_busy <= 0;
            received_data_ready <= 0; // Reset data ready flag
        end else begin
            case (rx_state)
                0: begin
                    if (rx == 0) begin
                        rx_state <= 1;
                        rx_busy <= 1;
                        rx_counter <= BAUD_DIV / 2;
                    end
                end
                1: begin
                    if (rx_counter == 0) begin
                        rx_counter <= BAUD_DIV;
                        rx_state <= 2;
                    end else begin
                        rx_counter <= rx_counter - 1;
                    end
                end
                // Additional states for RX data shift...
                default: begin
                    rx_state <= 0;
                end
            endcase
        end
    end

    // UART TX Logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_state <= 0;
            tx_counter <= 0;
            tx_shift_reg <= 0;
            tx_busy <= 0;
            send_data_ready <= 1; // Ready to send data after reset
        end else begin
            case (tx_state)
                0: begin
                    if (send_data_valid && send_data_ready) begin
                        tx_shift_reg <= send_data;
                        tx_busy <= 1;
                        tx_state <= 1;
                        send_data_ready <= 0; // Clear ready flag when sending data
                    end
                end
                1: begin
                    if (tx_counter == 0) begin
                        tx_counter <= BAUD_DIV;
                        tx_state <= 2;
                    end else begin
                        tx_counter <= tx_counter - 1;
                    end
                end
                // Additional states for TX data shift...
                default: begin
                    tx_state <= 0;
                end
            endcase
        end
    end
endmodule