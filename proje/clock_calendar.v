module clock_calendar(
    input wire clk,
    input wire rst,
    input wire pause,
    input wire fast,
    input wire [1:0] adjust_hour, // 00: no adjust, 01: increment, 10: decrement
    input wire [1:0] adjust_minute, // 00: no adjust, 01: increment, 10: decrement
    input wire [7:0] uart_data,
    input wire uart_valid,
    output reg [7:0] hour,
    output reg [7:0] minute, // Düzeltildi
    output reg [7:0] second,
    output reg [4:0] day,
    output reg [3:0] month,
    output reg [11:0] year
);
    reg [7:0] counter = 0;
    reg tick = 0;
    reg pause_reg = 0;
    reg fast_reg = 0;

    always @(posedge clk) begin
        if (rst) begin
            hour <= 8'd18;
            minute <= 8'd30;
            second <= 8'd0;
            day <= 5'd30;
            month <= 4'd7;
            year <= 12'd2024;
            pause_reg <= 0;
            fast_reg <= 0;
        end else if (!pause_reg) begin
            counter <= counter + 1;
            if (counter >= (fast_reg ? 25 : 50)) begin
                counter <= 0;
                tick <= 1;
            end else begin
                tick <= 0;
            end

            if (tick) begin
                second <= second + 1;
                if (second >= 60) begin
                    second <= 0;
                    minute <= minute + 1;
                end
                if (minute >= 60) begin
                    minute <= 0;
                    hour <= hour + 1;
                end
                if (hour >= 24) begin
                    hour <= 0;
                    day <= day + 1;
                end
                // Ay ve yıl kontrolü
                if ((month == 4 || month == 6 || month == 9 || month == 11) && day > 30) begin
                    day <= 1;
                    month <= month + 1;
                end else if ((month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) && day > 31) begin
                    day <= 1;
                    if (month == 12) begin
                        month <= 1;
                        year <= year + 1;
                    end else begin
                        month <= month + 1;
                    end
                end else if (month == 2) begin
                    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) begin
                        if (day > 29) begin
                            day <= 1;
                            month <= month + 1;
                        end
                    end else if (day > 28) begin
                        day <= 1;
                        month <= month + 1;
                    end
                end
            end
        end

        // Butonlar ile ayarlama
        if (adjust_hour == 2'b01) hour <= hour + 1;
        else if (adjust_hour == 2'b10) hour <= hour - 1;
        
        if (adjust_minute == 2'b01) minute <= minute + 1;
        else if (adjust_minute == 2'b10) minute <= minute - 1;

        // UART ile ayarlama
        if (uart_valid) begin
            // UART'dan gelen veri formatına göre ayarlama yapılabilir.
            // Örneğin, 'S' durdur/başlat, 'R' reset olabilir.
            if (uart_data == "S") pause_reg <= !pause_reg;
            else if (uart_data == "R") begin
                hour <= 8'd18;
                minute <= 8'd30;
                second <= 8'd0;
                day <= 5'd30;
                month <= 4'd7;
                year <= 12'd2024;
            end
        end
    end
endmodule