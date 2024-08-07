module camasir_sistemi(
    input clk,
    input [15:0] camasir,
    input basla,
    output bitti
);

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
    .temiz_camasir(temiz_camasir),
    .basla(yikama_bitti),
    .bitti(kurutma_bitti),
    .cikis(kuru_camasir)
);

katlama ka1(
    .clk(clk),
    .kuru_camasir(kuru_camasir),
    .basla(kurutma_bitti),
    .bitti(katlama_bitti),
    .cikis(katlanmis_camasir)
);

yerlestirme y2(
    .clk(clk),
    .katlanmis_camasir(katlanmis_camasir),
    .basla(katlama_bitti),
    .bitti(yerlestirme_bitti)
);

assign bitti = yerlestirme_bitti;

endmodule