module bamsi_alp_sayisi(
    input [1:0] H1,
    input [1:0] A1,
    input [1:0] H2,
    input [1:0] A2,
    output [1:0] S
);

wire [1:0] newG1;
wire [1:0] newR1;
wire [1:0] sayi1;

not (newG1[0],A1[1]);
buf (newG1[1],A1[1]);

not (newR1[0],H1[1]);
buf (newR1[1],H1[1]);

wire [1:0] newG2;
wire [1:0] newR2;
wire [1:0] sayi2;

not (newG2[0],A2[1]);
buf (newG2[1],A2[1]);

not (newR2[0],H2[1]);
buf (newR2[1],H2[1]);

alp_sayisi a1(
    .Y (1'b1),
    .G (newG1),
    .R (newR1),
    .S (sayi1)
);

alp_sayisi a2(
    .Y (1'b1),
    .G (newG2),
    .R (newR2),
    .S (sayi2)
);

//S[1] = sayi1[1] + sayi1[1]'.sayi2[1]
//S[0] = sayi1[1]. sayi1[0]' + sayi2[1].sayi2[0] + sayi1[0]'.sayi2[1]'.sayi2[0] + sayi1[1]'.sayi1[0].sayi2[1]'
//sayi1 ve sayi2 arasinda karsilastirma yapilir
//karsilastirma kodunu yazmak icin zamanim yetmedi

endmodule