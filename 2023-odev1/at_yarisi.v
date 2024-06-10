module at_yarisi(
    input  [1:0] beyaz_at_hiz,
    input  [1:0] siyah_at_hiz,
    input  [1:0] boz_at_hiz,
    input  [1:0] beyaz_jokey_komut,
    input  [1:0] siyah_jokey_komut,
    input  [1:0] boz_jokey_komut,
    output [1:0] kazanan_at
);

wire [1:0] beyaz_at_son_hiz;
wire [1:0] siyah_at_son_hiz;
wire [1:0] boz_at_son_hiz;

//beyaz_at_son_hiz[0] = h0'.k0 + h0.k1 + h1.k0 + h1.h0'.k1'
wire notbeyazhiz0;
wire notbeyazkomut1;

not (notbeyazhiz0,beyaz_at_hiz[0]);
not (notbeyazkomut1,beyaz_jokey_komut[1]);

wire wire1_beyaz;
and (wire1_beyaz,notbeyazhiz0,beyaz_jokey_komut[0]);

wire wire2_beyaz;
and (wire2,beyaz_at_hiz[0],beyaz_jokey_komut[1]);

wire wire3_beyaz;
and (wire3_beyaz,beyaz_at_hiz[1],beyaz_jokey_komut[0]);

wire wire4_beyaz;
and (wire4_beyaz,beyaz_at_hiz[1],notbeyazhiz0,notbeyazkomut1);

or (beyaz_at_son_hiz[0],wire1_beyaz,wire2_beyaz,wire3_beyaz,wire4_beyaz);

//beyaz_at_son_hiz[1] = h0.k0 + h1.k0 + h1.k1 + h1.h0

wire wire5_beyaz;
and (wire5_beyaz,beyaz_at_hiz[0],beyaz_jokey_komut[0]);

wire wire6_beyaz;
and (wire6_beyaz,beyaz_at_hiz[1],beyaz_jokey_komut[0]);

wire wire7_beyaz;
and (wire7_beyaz,beyaz_at_hiz[1],beyaz_jokey_komut[1]);

wire wire8_beyaz;
and (wire8_beyaz,beyaz_at_hiz[1],beyaz_at_hiz[0]);

or(beyaz_at_son_hiz[1],wire5_beyaz,wire6_beyaz,wire7_beyaz,wire8_beyaz);

//siyah_at_son_hiz
wire notsiyahhiz0;
wire notsiyahkomut1;

not (notsiyahhiz0, siyah_at_hiz[0]);
not (notsiyahkomut1, siyah_jokey_komut[1]);

wire wire1_siyah;
and (wire1_siyah, notsiyahhiz0, siyah_jokey_komut[0]);

wire wire2_siyah;
and (wire2_siyah, siyah_at_hiz[0], siyah_jokey_komut[1]);

wire wire3_siyah;
and (wire3_siyah, siyah_at_hiz[1], siyah_jokey_komut[0]);

wire wire4_siyah;
and (wire4_siyah, siyah_at_hiz[1], notsiyahhiz0, notsiyahkomut1);

or (siyah_at_son_hiz[0], wire1_siyah, wire2_siyah, wire3_siyah, wire4_siyah);

wire wire5_siyah;
and (wire5_siyah, siyah_at_hiz[0], siyah_jokey_komut[0]);

wire wire6_siyah;
and (wire6_siyah, siyah_at_hiz[1], siyah_jokey_komut[0]);

wire wire7_siyah;
and (wire7_siyah, siyah_at_hiz[1], siyah_jokey_komut[1]);

wire wire8_siyah;
and (wire8_siyah, siyah_at_hiz[1], siyah_at_hiz[0]);

or (siyah_at_son_hiz[1], wire5_siyah, wire6_siyah, wire7_siyah, wire8_siyah);

//boz_at_son_hiz
wire notbozhiz0;
wire notbozkomut1;

not (notbozhiz0, boz_at_hiz[0]);
not (notbozkomut1, boz_jokey_komut[1]);

wire wire1_boz;
and (wire1_boz, notbozhiz0, boz_jokey_komut[0]);

wire wire2_boz;
and (wire2_boz, boz_at_hiz[0], boz_jokey_komut[1]);

wire wire3_boz;
and (wire3_boz, boz_at_hiz[1], boz_jokey_komut[0]);

wire wire4_boz;
and (wire4_boz, boz_at_hiz[1], notbozhiz0, notbozkomut1);

or (boz_at_son_hiz[0], wire1_boz, wire2_boz, wire3_boz, wire4_boz);

wire wire5_boz;
and (wire5_boz, boz_at_hiz[0], boz_jokey_komut[0]);

wire wire6_boz;
and (wire6_boz, boz_at_hiz[1], boz_jokey_komut[0]);

wire wire7_boz;
and (wire7_boz, boz_at_hiz[1], boz_jokey_komut[1]);

wire wire8_boz;
and (wire8_boz, boz_at_hiz[1], boz_at_hiz[0]);

or (boz_at_son_hiz[1], wire5_boz, wire6_boz, wire7_boz, wire8_boz);

//karsilastirma
wire A, B, C, D, E, F;
buf(A, beyaz_at_son_hiz[1]);
buf(B, beyaz_at_son_hiz[0]);
buf(C, siyah_at_son_hiz[1]);
buf(D, siyah_at_son_hiz[0]);
buf(E, boz_at_son_hiz[1]);
buf(F, boz_at_son_hiz[0]);
    
wire nA, nB, nC, nD, nE, nF;
not(nA, A);
not(nB, B);
not(nC, C);
not(nD, D);
not(nE, E);
not(nF, F);
    
// K1 = A'C'E + B'C'EF + A'D'EF + B'D'EF + A'B'C'D'F
wire w11, w12, w13, w14, w15;
and(w11, nA, nC, E);
and(w12, nB, nC, E, F);
and(w13, nA, nD, E, F);
and(w14, nB, nD, E, F);
and(w15, nA, nB, nC, nD, F);
or(kazanan_at[1], w11, w12, w13, w14, w15);
    
// K0 = A'CE' + A'CF' + A'CD + B'CD + A'B'DE'
wire w21, w22, w23, w24, w25;
and(w21, nA, C, nE);
and(w22, nA, C, nF);
and(w23, nA, C, D);
and(w24, nB, C, D);
and(w25, nA, nB, D, nE);
or(kazanan_at[0], w21, w22, w23, w24, w25);

endmodule