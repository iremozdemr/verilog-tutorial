module camasir_sistemi_v2(
    input clk,
    input [15:0] camasir,
    input basla,
    output bitti
);

reg [15:0] buffer1, buffer2, buffer3;
wire [15:0] temiz_camasir, kuru_camasir;
wire [3:0] katlanmis_camasir;
wire yikama_bitti, kurutma_bitti, katlama_bitti, yerlestirme_bitti;

yikama y1(
    .clk(clk),
    .camasir(camasir),
    .basla(basla),
    .bitti(yikama_bitti),
    .cikis(temiz_camasir)
);

kurutma k1(
    .clk(clk),
    .temiz_camasir(buffer1),
    .basla(yikama_bitti),
    .bitti(kurutma_bitti),
    .cikis(kuru_camasir)
);

katlama ka1(
    .clk(clk),
    .kuru_camasir(buffer2),
    .basla(kurutma_bitti),
    .bitti(katlama_bitti),
    .cikis(katlanmis_camasir)
);

yerlestirme y2(
    .clk(clk),
    .katlanmis_camasir(buffer3),
    .basla(katlama_bitti),
    .bitti(yerlestirme_bitti)
);

assign bitti = yerlestirme_bitti;

always @(posedge clk) begin
    if (yikama_bitti) begin
        buffer1 <= temiz_camasir;
    end
    if (kurutma_bitti) begin
        buffer2 <= kuru_camasir;
    end
    if (katlama_bitti) begin
        buffer3 <= katlanmis_camasir;
    end
end

endmodule