module seven_segment_display(
    input wire clk,
    input wire [7:0] seconds,
    input wire [7:0] minutes,
    input wire [7:0] hours,
    output reg [7:0] seg,
    output reg [3:0] an
);

    reg [3:0] bcd;
    reg [1:0] display_state;
    reg [31:0] clk_divider;

    always @(posedge clk) begin
        clk_divider <= clk_divider + 1;
        if (clk_divider == 32'd500000) begin // Adjust for desired refresh rate
            clk_divider <= 0;
            display_state <= display_state + 1;
        end
    end

    always @(*) begin
        bcd = 4'b0000;  // Varsayılan değer
        an = 4'b1111;   // Varsayılan değer
        case(display_state)
            2'b00: begin
                bcd = seconds % 10;
                an = 4'b1110; 
            end
            2'b01: begin
                bcd = (seconds / 10) % 10;
                an = 4'b1101;
            end
            2'b10: begin
                bcd = minutes % 10;
                an = 4'b1011; 
            end
            2'b11: begin
                bcd = (minutes / 10) % 10;
                an = 4'b0111; 
            end
        endcase
    end

    always @(*) begin
        case(bcd)
            4'b0000: seg = 8'b11000000; // 0
            4'b0001: seg = 8'b11111001; // 1
            4'b0010: seg = 8'b10100100; // 2
            4'b0011: seg = 8'b10110000; // 3
            4'b0100: seg = 8'b10011001; // 4
            4'b0101: seg = 8'b10010010; // 5
            4'b0110: seg = 8'b10000010; // 6
            4'b0111: seg = 8'b11111000; // 7
            4'b1000: seg = 8'b10000000; // 8
            4'b1001: seg = 8'b10010000; // 9
            default: seg = 8'b11111111; // Blank
        endcase
    end

endmodule