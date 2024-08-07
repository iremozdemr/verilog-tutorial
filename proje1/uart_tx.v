module uart_tx(
    input wire clk,
    input wire [7:0] data_in,
    input wire send,
    output reg tx,
    output reg ready
);
    parameter BAUD_RATE = 9600;
    parameter CLK_FREQ = 50000000;
    parameter BAUD_COUNT = CLK_FREQ / BAUD_RATE;

    reg [15:0] baud_counter = 0;
    reg [3:0] bit_counter = 0;
    reg [7:0] data = 0;
    reg sending = 0;

    always @(posedge clk) begin
        if (send && ready) begin
            sending <= 1;
            ready <= 0;
            data <= data_in;
            tx <= 0; // Start bit
            baud_counter <= BAUD_COUNT - 1;
        end else if (sending) begin
            if (baud_counter == 0) begin
                baud_counter <= BAUD_COUNT - 1;
                if (bit_counter < 8) begin
                    tx <= data[bit_counter];
                    bit_counter <= bit_counter + 1;
                end else if (bit_counter == 8) begin
                    tx <= 1; // Stop bit
                    bit_counter <= bit_counter + 1;
                end else begin
                    sending <= 0;
                    ready <= 1;
                    bit_counter <= 0;
                end
            end else begin
                baud_counter <= baud_counter - 1;
            end
        end
    end
endmodule