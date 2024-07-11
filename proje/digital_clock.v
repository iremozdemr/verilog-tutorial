module digital_clock(
    input wire clk,
    input wire rst,
    input wire [1:0] button, // button[0]: saat, button[1]: dakika
    input wire [1:0] switch, // switch[0]: saniye, switch[1]: hızlandır/yavaşlat
    input wire uart_rx,
    output wire [6:0] seg_hour_high,
    output wire [6:0] seg_hour_low,
    output wire [6:0] seg_min_high,
    output wire [6:0] seg_min_low,
    output reg [5:0] leds
);
    reg pause = 0;
    reg fast = 0;
    wire [7:0] uart_data;
    wire uart_valid;

    uart_rx uart_receiver(
        .clk(clk),
        .rx(uart_rx),
        .data_out(uart_data),
        .data_valid(uart_valid)
    );

    wire [7:0] hour;
    wire [7:0] minute;
    wire [7:0] second;
    wire [4:0] day;
    wire [3:0] month;
    wire [11:0] year;

    clock_calendar clock_cal(
        .clk(clk),
        .rst(rst),
        .pause(pause),
        .fast(fast),
        .adjust_hour(button[1:0]),
        .adjust_minute(button[1:0]),
        .uart_data(uart_data),
        .uart_valid(uart_valid),
        .hour(hour),
        .minute(minute),
        .second(second),
        .day(day),
        .month(month),
        .year(year)
    );

    seven_segment seg_hour_high_inst(
        .digit(hour / 10),
        .segments(seg_hour_high)
    );

    seven_segment seg_hour_low_inst(
        .digit(hour % 10),
        .segments(seg_hour_low)
    );

    seven_segment seg_min_high_inst(
        .digit(minute / 10),
        .segments(seg_min_high)
    );

    seven_segment seg_min_low_inst(
        .digit(minute % 10),
        .segments(seg_min_low)
    );

    always @(posedge clk) begin
        if (rst) begin
            leds <= 6'b000000;
        end else begin
            leds[0] <= second % 2;  // Blink LED with seconds
            leds[1] <= pause;       // Pause indicator
            leds[2] <= fast;        // Fast mode indicator
        end
    end
endmodule