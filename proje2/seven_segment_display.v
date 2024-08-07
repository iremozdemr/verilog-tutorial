//bu modül, saat, dakika ve saniye bilgilerini dört haneli bir 7-segment display üzerinde göstermek için kullanılır
//clock sinyalini böler, hangi display'in aktif olacağını ve hangi bcd değerinin gösterileceğini belirler
//bcd değerini 7-segment display formatına çevirir ve ilgili segmentleri yakar

module seven_segment_display(
    input wire clk,
    //saat sinyali
    input wire [7:0] seconds,
    //8 bitlik saniye değeri
    input wire [7:0] minutes,
    //8 bitlik dakika değeri
    input wire [7:0] hours,
    //8 bitlik saat değeri
    output reg [7:0] seg,
    //her bit bir segmenti temsil eder
    output reg [3:0] an
    //hangi 7 segment display'in aktif olduğunu gösterir
);

    reg [3:0] bcd;
    //4 bitlik binary coded decimal
    //bu değer bir rakamı temsil eder
    reg [1:0] display_state;
    //hangi 7 segment display'in aktif olduğunu gösterir
    reg [31:0] clk_divider;
    //32 bitlik saat bölücü
    //display'ler arasında geçiş yapmak için kullanılır
    
    always @(posedge clk) begin
        clk_divider <= clk_divider + 1;
        if (clk_divider == 32'd500000) begin // daha uzun bir süre için ayarlayın
            clk_divider <= 0;
            display_state <= display_state + 1;
        end
    end
    //clock divider belirli bir süre olduğunda display state bir sonraki değere geçer

    always @(*) begin
        case(display_state)
            2'b00: begin
                bcd = seconds % 10;
                //saniyelerin birler basamağı
                an = 4'b1110; 
                //sağdaki display'i etkinleştir
            end
            2'b01: begin
                bcd = (seconds / 10) % 10;
                //saniyelerin onlar basamağı
                an = 4'b1101;
                //ikinci sağdaki display'i etkinleştir
            end
            2'b10: begin
                bcd = minutes % 10;
                //dakikaların birler basamağı
                an = 4'b1011; 
                //üçüncü sağdaki display'i etkinleştir
            end
            2'b11: begin
                bcd = (minutes / 10) % 10;
                //dakikaların onlar basamağı
                an = 4'b0111; 
                //soldaki display'i etkinleştir
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
            default: seg = 8'b11111111; // boş
        endcase
    end

endmodule