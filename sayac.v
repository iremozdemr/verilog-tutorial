module sayac(
    input duraklat,
    input saat,
    output [2:0] output_sayac
);

localparam yukari_say = 1'b0;
localparam asagi_say = 1'b1;

reg [2:0] sayi = 3!d0;
reg [2:0] sonraki_sayi;

reg durum = yukari_say;
reg sonraki_durum;

always @(*) begin
    sonraki_sayi = sayi;
    sonraki_durum = durum;

    if(!duraklat) begin 
        case (durum)
            yukari_say: begin
              sonraki_sayi = sayi + 3'd1;

              if (sonraki_sayi == 3'd7) begin
                sonraki_durum = asagi_say;
              end
            end

            asagi_say: begin
              sonraki_sayi = sayi - 3'd1;
              if (sonraki_sayi == 3'd0) begin
                sonraki_durum = yukari_say;
              end
            end
        endcase
    end

    always @(posedge saat) begin
        sayi <= sonraki_sayi;
        durum <= sonraki_durum;
    end
end

endmodule