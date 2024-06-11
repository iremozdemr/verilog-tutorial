module alp_sayisi(
    input Y,
    input [1:0] G,
    input [1:0] R,
    output [1:0] S
);

wire [1:0] BB;

bolge b1(
    .Y (Y),
    .G (G),
    .R (R),
    .B (BB)
);

wire notB0;
wire notB1;

not (notB0,BB[0]);
not (notB1,BB[1]);

//S[0] = B[0]'
buf (S[0],notB0);

//S[1] = B[1]'.B[0] + B[1].B[0]'
wire wire1;
and (wire1,notB1,BB[0]);

wire wire2;
and (wire2,BB[1],notB0);

or (S[1],wire1,wire2);

endmodule