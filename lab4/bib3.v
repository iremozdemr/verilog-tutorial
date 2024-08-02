module bib3(
    input [8:0] buyruk,    //9 bitlik giriş sinyali
    output reg [3:0] sonuc //4 bitlik çıkış sinyali
);

//işlem türlerini belirlemek için localparam tanımlamaları
localparam topla = 3'b000;
localparam cikar = 3'b001;
localparam bitwise_and = 3'b010;
localparam bitwise_or = 3'b011;
localparam and_r = 3'b100;
localparam or_r = 3'b101;
localparam cift_eslik = 3'b110;
localparam tek_eslik = 3'b111;

wire [2:0] operator = buyruk[8:6]; //işlem türünü belirten 3 bit
wire [2:0] a = buyruk[5:3];        //ilk sayı
wire [2:0] b = buyruk[2:0];        //ikinci sayı

initial sonuc = 4'b0000; 
always @(*) begin
    case (operator)
        topla:       sonuc = a + b;           //topla
        cikar:       sonuc = a - b;           //çıkar
        bitwise_and: sonuc = a & b;           //bitwise and
        bitwise_or:  sonuc = a | b;           //bitwise or
        and_r:       sonuc = &a;              //and_r
        or_r:        sonuc = |a;              //or_r
        cift_eslik:  sonuc = ^a;              //çift eşlik
        tek_eslik:   sonuc = ~^a;             //tek eşlik
    endcase
end

endmodule