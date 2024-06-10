module odev1_fonk(
    input A,
    input B,
    input C,
    input D,
    input E,
    output F
);

wire notA;
wire notB;
wire notC;
wire notD;
wire notE;

not (notA,A);
not (notB,B);
not (notC,C);
not (notD,D);
not (notE,E);

wire wire1;
and (wire1,A,notB,C,notD,notE);

wire wire2;
and (wire2,notB,notC);

wire part1;
or (wire1,wire2,D);

wire wire3;
and (notA,B,notD);

wire wire4;
and (wire4,B,D,E);

wire part2;
or (part2,wire3,wire4);

wire notpart2;
not (notpart2,part2);

or(F,part1,notpart2);

endmodule