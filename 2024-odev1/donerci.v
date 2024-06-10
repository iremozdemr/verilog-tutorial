module donerci(
    input [1:0] et_hiz,
    input [1:0] kiyma_hiz,
    input [1:0] tavuk_hiz,
    input [1:0] et_komut,
    input [1:0] kiyma_komut,
    input [1:0] tavuk_komut,
    input [1:0] en_cok_satan_doner
);

//nasil yaptim:
//1- etin, tavukun, kiymanin yeni hizini bulmak icin 
//her iki bit icin ayri dogruluk tablosu olusturdum
//2- karno haritasi olusturdum
//3- fonksiyonu olusturdum 
//4- kapilari cizdim

// etin yeni hızı için işlemler
wire [1:0] etin_yeni_hizi;

wire noth0_et;
wire noth1_et;
wire notk0_et;
wire notk1_et;

not (noth0_et,et_hiz[0]);
not (noth1_et,et_hiz[1]);
not (notk0_et,et_komut[0]);
not (notk1_et,et_komut[1]);

wire wire1_et, wire2_et, wire3_et, wire4_et, wire5_et;

and (wire1_et,et_hiz[1],notk1_et,notk0_et);
and (wire2_et,et_hiz[1],et_komut[1]);
and (wire3_et,noth1_et,et_komut[1],et_komut[0]);
and (wire4_et,noth1_et,noth0_et,et_komut[0]);
and (wire5_et,noth1_et,noth0_et,et_komut[1]);

or(etin_yeni_hizi[1],wire1_et,wire2_et,wire3_et,wire4_et,wire5_et);

wire wire6_et, wire7_et, wire8_et;

and(wire6_et,et_komut[1],et_komut[0]);
and(wire7_et,notk0_et,noth1_et,et_hiz[0]);
and(wire8_et,notk1_et,notk0_et,et_hiz[0]);

or (etin_yeni_hizi[0],wire6_et,wire7_et,wire8_et);


// kiymanin yeni hizini bulmak icin islemler 
wire [1:0] kiymanin_yeni_hizi;
wire noth0_kiyma, noth1_kiyma, notk0_kiyma, notk1_kiyma;
wire wire1_kiyma, wire2_kiyma, wire3_kiyma, wire4_kiyma, wire5_kiyma, wire6_kiyma, wire7_kiyma, wire8_kiyma;

not (noth0_kiyma, kiyma_hiz[0]);
not (noth1_kiyma, kiyma_hiz[1]);
not (notk0_kiyma, kiyma_komut[0]);
not (notk1_kiyma, kiyma_komut[1]);

and (wire1_kiyma, kiyma_hiz[1], notk1_kiyma, notk0_kiyma);
and (wire2_kiyma, kiyma_hiz[1], kiyma_komut[1]);
and (wire3_kiyma, noth1_kiyma, kiyma_komut[1], kiyma_komut[0]);
and (wire4_kiyma, noth1_kiyma, noth0_kiyma, kiyma_komut[0]);
and (wire5_kiyma, noth1_kiyma, noth0_kiyma, kiyma_komut[1]);

or (kiymanin_yeni_hizi[1], wire1_kiyma, wire2_kiyma, wire3_kiyma, wire4_kiyma, wire5_kiyma);

and (wire6_kiyma, kiyma_komut[1], kiyma_komut[0]);
and (wire7_kiyma, notk0_kiyma, noth1_kiyma, kiyma_hiz[0]);
and (wire8_kiyma, notk1_kiyma, notk0_kiyma, kiyma_hiz[0]);

or (kiymanin_yeni_hizi[0], wire6_kiyma, wire7_kiyma, wire8_kiyma);


// tavukun yeni hizini bulmak icin islemler
wire [1:0] tavukun_yeni_hizi;
wire noth0_tavuk, noth1_tavuk, notk0_tavuk, notk1_tavuk;
wire wire1_tavuk, wire2_tavuk, wire3_tavuk, wire4_tavuk, wire5_tavuk, wire6_tavuk, wire7_tavuk, wire8_tavuk;

not (noth0_tavuk, tavuk_hiz[0]);
not (noth1_tavuk, tavuk_hiz[1]);
not (notk0_tavuk, tavuk_komut[0]);
not (notk1_tavuk, tavuk_komut[1]);

and (wire1_tavuk, tavuk_hiz[1], notk1_tavuk, notk0_tavuk);
and (wire2_tavuk, tavuk_hiz[1], tavuk_komut[1]);
and (wire3_tavuk, noth1_tavuk, tavuk_komut[1], tavuk_komut[0]);
and (wire4_tavuk, noth1_tavuk, noth0_tavuk, tavuk_komut[0]);
and (wire5_tavuk, noth1_tavuk, noth0_tavuk, tavuk_komut[1]);

or (tavukun_yeni_hizi[1], wire1_tavuk, wire2_tavuk, wire3_tavuk, wire4_tavuk, wire5_tavuk);

and (wire6_tavuk, tavuk_komut[1], tavuk_komut[0]);
and (wire7_tavuk, notk0_tavuk, noth1_tavuk, tavuk_hiz[0]);
and (wire8_tavuk, notk1_tavuk, notk0_tavuk, tavuk_hiz[0]);

or (tavukun_yeni_hizi[0], wire6_tavuk, wire7_tavuk, wire8_tavuk);


// en hizlinin belirlenmesi
wire hiz_et_gt_kiyma_1, hiz_et_gt_kiyma_0, hiz_et_gt_kiyma;
wire hiz_et_gt_tavuk_1, hiz_et_gt_tavuk_0, hiz_et_gt_tavuk;
wire hiz_kiyma_gt_tavuk_1, hiz_kiyma_gt_tavuk_0, hiz_kiyma_gt_tavuk;
wire et_hizli, kiyma_hizli, tavuk_hizli;

// et vs kiyma
and (hiz_et_gt_kiyma_1, etin_yeni_hizi[1], ~kiymanin_yeni_hizi[1]);
and (hiz_et_gt_kiyma_0, etin_yeni_hizi[0], ~kiymanin_yeni_hizi[0]);
or (hiz_et_gt_kiyma, hiz_et_gt_kiyma_1, hiz_et_gt_kiyma_0);

// et vs tavuk
and (hiz_et_gt_tavuk_1, etin_yeni_hizi[1], ~tavukun_yeni_hizi[1]);
and (hiz_et_gt_tavuk_0, etin_yeni_hizi[0], ~tavukun_yeni_hizi[0]);
or (hiz_et_gt_tavuk, hiz_et_gt_tavuk_1, hiz_et_gt_tavuk_0);

// kiyma vs tavuk
and (hiz_kiyma_gt_tavuk_1, kiymanin_yeni_hizi[1], ~tavukun_yeni_hizi[1]);
and (hiz_kiyma_gt_tavuk_0, kiymanin_yeni_hizi[0], ~tavukun_yeni_hizi[0]);
or (hiz_kiyma_gt_tavuk, hiz_kiyma_gt_tavuk_1, hiz_kiyma_gt_tavuk_0);

and (et_hizli, hiz_et_gt_kiyma, hiz_et_gt_tavuk);
    
wire not_hiz_et_gt_kiyma, not_hiz_kiyma_gt_tavuk;
not (not_hiz_et_gt_kiyma, hiz_et_gt_kiyma);
not (not_hiz_kiyma_gt_tavuk, hiz_kiyma_gt_tavuk);
    
and (kiyma_hizli, not_hiz_et_gt_kiyma, hiz_kiyma_gt_tavuk);
and (tavuk_hizli, not_hiz_et_gt_tavuk, not_hiz_kiyma_gt_tavuk);

wire en_cok_satan_doner_0, en_cok_satan_doner_1;
    
or (en_cok_satan_doner_0, kiyma_hizli, tavuk_hizli);
or (en_cok_satan_doner_1, tavuk_hizli);
    
assign en_cok_satan_doner[0] = en_cok_satan_doner_0;
assign en_cok_satan_doner[1] = en_cok_satan_doner_1;

endmodule

//karsilastirma icin ornek kod
/*
wire [1:0] hiz_et, hiz_kiyma, hiz_tavuk;
wire et_vs_kiyma, et_vs_tavuk, kiyma_vs_tavuk;
wire et_hizli, kiyma_hizli, tavuk_hizli;

assign hiz_et = etin_yeni_hizi;
assign hiz_kiyma = kiymanin_yeni_hizi;
assign hiz_tavuk = tavukun_yeni_hizi;

assign et_vs_kiyma = (hiz_et > hiz_kiyma) ? 1 : 0;
assign et_vs_tavuk = (hiz_et > hiz_tavuk) ? 1 : 0;
assign kiyma_vs_tavuk = (hiz_kiyma > hiz_tavuk) ? 1 : 0;

assign et_hizli = (et_vs_kiyma & et_vs_tavuk) ? 1 : 0;
assign kiyma_hizli = (~et_vs_kiyma & kiyma_vs_tavuk) ? 1 : 0;
assign tavuk_hizli = (~et_vs_tavuk & ~kiyma_vs_tavuk) ? 1 : 0;

assign en_cok_satan_doner = et_hizli ? 2'b00 : (kiyma_hizli ? 2'b01 : 2'b10);
*/