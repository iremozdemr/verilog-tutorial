module digital_clock (
    input wire clk,
    input wire rst,
    input wire [3:0] btn, // 2 buttons for hour and 2 buttons for minute adjustment
    input wire [1:0] sw,  // switches for second adjustment and speed control
    input wire uart_rx,   // UART receive line
    output wire uart_tx,  // UART transmit line
    output wire [7:0] seg, // 7-segment display segments
    output wire [3:0] an,  // 7-segment display anodes
    output wire [7:0] led  // LEDs for binary second display
);

    // Clock dividers and counters
    reg [25:0] clk_div;
    reg [7:0] seconds, minutes, hours;
    reg pause, speed_up;
    reg valid_command; // Tanımlanmamış sinyal eklendi

    // UART module instantiation
    wire [7:0] received_data;
    reg [7:0] send_data;
    reg send_data_valid;
    wire send_data_ready;
    wire received_data_ready;

    uart uart_inst (
        .clk(clk),
        .rst(rst),
        .rx(uart_rx),
        .tx(uart_tx),
        .received_data(received_data),
        .received_data_ready(received_data_ready),
        .send_data(send_data),
        .send_data_valid(send_data_valid),
        .send_data_ready(send_data_ready)
    );

    // Initial settings
    initial begin
        seconds = 8'h00;
        minutes = 8'h30;
        hours = 8'h18;
        pause = 0;
        speed_up = 0;
        valid_command = 0; // Varsayılan başlangıç değeri
    end

    // Clock divider and timekeeping logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_div <= 0;
            seconds <= 8'h00;
            minutes <= 8'h30;
            hours <= 8'h18;
            pause <= 0;
            speed_up <= 0;
        end else if (!pause) begin
            if (clk_div == (speed_up ? 50000000 : 100000000)) begin
                clk_div <= 0;
                seconds <= seconds + 1;
                if (seconds == 60) begin
                    seconds <= 0;
                    minutes <= minutes + 1;
                    if (minutes == 60) begin
                        minutes <= 0;
                        hours <= hours + 1;
                        if (hours == 24) hours <= 0;
                    end
                end
            end else begin
                clk_div <= clk_div + 1;
            end
            
            // Time adjustment logic
            if (btn[0]) hours <= (hours == 23) ? 8'h00 : hours + 1;
            if (btn[1]) hours <= (hours == 0) ? 8'h23 : hours - 1;
            if (btn[2]) minutes <= (minutes == 59) ? 8'h00 : minutes + 1;
            if (btn[3]) minutes <= (minutes == 0) ? 8'h59 : minutes - 1;

            // Toggle speed up on switch change
            if (sw[1]) speed_up <= ~speed_up;
        end
    end

    // Display logic for 7-segment display
    seven_segment_display display_inst (
        .clk(clk),
        .seconds(seconds),
        .minutes(minutes),
        .hours(hours),
        .seg(seg),
        .an(an)
    );

    // Display logic for LEDs
    assign led = seconds;

    // Control logic for pause and speed up
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pause <= 0;
            speed_up <= 0;
        end else begin
            if (btn[4]) pause <= ~pause;
        end
    end

    // UART logic for sending data
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            send_data <= 8'b0;
            send_data_valid <= 0;
        end else begin
            if (valid_command) begin
                send_data_valid <= 1;
            end else begin
                send_data_valid <= 0;
            end
        end
    end
endmodule