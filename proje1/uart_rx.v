module uart_rx(
    input wire clk,
    input wire rx,
    output reg [7:0] data_out,
    output reg data_valid
);
    parameter BAUD_RATE = 9600;
    parameter CLK_FREQ = 50000000;
    parameter BAUD_COUNT = CLK_FREQ / BAUD_RATE;

    reg [15:0] baud_counter = 0;
    reg [3:0] bit_counter = 0;
    reg [7:0] data = 0;
    reg receiving = 0;

    always @(posedge clk) begin
        if (!rx && !receiving) begin
            receiving <= 1;
            baud_counter <= BAUD_COUNT / 2;
        end else if (receiving) begin
            if (baud_counter == 0) begin
                baud_counter <= BAUD_COUNT - 1;
                data[bit_counter] <= rx;
                bit_counter <= bit_counter + 1;
                if (bit_counter == 7) begin
                    data_out <= data;
                    data_valid <= 1;
                    receiving <= 0;
                    bit_counter <= 0;
                end
            end else begin
                baud_counter <= baud_counter - 1;
            end
        end else begin
            data_valid <= 0;
        end
    end
endmodule