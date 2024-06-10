module kilit_acici(
    input [2:0] sag_adim,
    input [1:0] sol_adim,
    input [5:0] kilit_sifre,
    output kilit_acik
);
    
wire [5:0] sonuc;
wire A, B, C, D, E;
wire nA, nB, nC, nD, nE;
    
buf(A, sag_adim[2]);
buf(B, sag_adim[1]);
buf(C, sag_adim[0]);
buf(D, sol_adim[1]);
buf(E, sol_adim[0]);
    
not(nA, A);
not(nB, B);
not(nC, C);
not(nD, D);
not(nE, E);
    
// SONUC[5] = A'B'CD'E + A'BCDE' + AB'CDE + ABCD'E'
wire w51, w52, w53, w54;
and(w51, nA, nB, C, nD, E);
and(w52, nA, B, C, D, nE);
and(w53, A, nB, C, D, E);
and(w54, A, B, C, nD, nE);
or(sonuc[5], w51, w52, w53, w54);
    
// SONUC[4] = A'B'DE' + A'C'DE' + A'BDE + AB'D'E' + AC'D'E' + ABD'E + A'B'C'D'E + AB'C'DE
wire w41, w42, w43, w44, w45, w46, w47, w48;
and(w41, nA, nB, D, nE);
and(w42, nA, nC, D, nE);
and(w43, nA, B, D, E);
and(w44, A, nB, nD, nE);
and(w45, A, nC, nD, nE);
and(w46, A, B, nD, E);
and(w47, nA, nB, nC, nD, E);
and(w48, A, nB, nC, D, E);
or(sonuc[4], w41, w42, w43, w44, w45, w46, w47, w48);
    
// SONUC[3] = B'C'E + BC'E' + A'B'CD + A'CDE + A'BD'E' + AB'CD' + ACD'E + ABDE'
wire w31, w32, w33, w34, w35, w36, w37, w38;
and(w31, nB, nC, E);
and(w32, B, nC, nE);
and(w33, nA, nB, C, D);
and(w34, nA, C, D, E);
and(w35, nA, B, nD, nE);
and(w36, A, nB, C, nD);
and(w37, A, C, nD, E);
and(w38, A, B, D, nE);
or(sonuc[3], w31, w32, w33, w34, w35, w36, w37, w38);
    
// SONUC[2] = A'C'DE' + A'CD'E' + A'BC'D + A'BCD' + AC'D'E' + ACDE' + ABC'D' + ABCD + A'B'C'D'E + A'B'CDE + AB'C'DE + AB'CD'E
wire w21, w22, w23, w24, w25, w26, w27, w28, w29, w210, w211, w212;
and(w21,  nA, nC, D, nE);
and(w22,  nA, C, nD, nE);
and(w23,  nA, B, nC, D);
and(w24,  nA, B, C, nD);
and(w25,  A, nC, nD, nE);
and(w26,  A, C, D, nE);
and(w27,  A, B, nC, nD);
and(w28,  A, B, C, D);
and(w29,  nA, nB, nC, nD, E);
and(w210, nA, nB, C, D, E);
and(w211, A, nB, nC, D, E);
and(w212, A, nB, C, nD, E);
or(sonuc[2], w21, w22, w23, w24, w25, w26, w27, w28, w29, w210, w211, w212);
    
// SONUC[1] = B'E + BE'
xor(sonuc[1], B, E);
    
// SONUC[0] = C
buf(sonuc[0], C);
    
// karsilastirma
wire [5:0] k;
xnor(k[5], sonuc[5], kilit_sifre[5]);
xnor(k[4], sonuc[4], kilit_sifre[4]);
xnor(k[3], sonuc[3], kilit_sifre[3]);
xnor(k[2], sonuc[2], kilit_sifre[2]);
xnor(k[1], sonuc[1], kilit_sifre[1]);
xnor(k[0], sonuc[0], kilit_sifre[0]);
and(kilit_acik, k[5], k[4], k[3], k[2], k[1], k[0]);
    
endmodule