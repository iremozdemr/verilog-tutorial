module odev1_devre(
    input A,
    input B,
    input C,
    input D,
    input E,
    output F;
);

wire notA;
wire notB;
wire notC;
wire notE;

not(notA,A);
not(notB,B);
not(notC,C);
not(notE,E);

wire wire1;
and(wire1,notA,B,C,D,notE);

wire wire2;
and(wire2,C,notE);

wire part1;
or(part1,wire1,wire2,A);

wire wireX;
and(wireX,notC,E,D);

wire wireY;
and(wireY,A,notB,C,D,notE);

wire part2;
or(part2,B,wireX,wireY);

wire notpart2;
not(notpart2,part2);

or(F,part1,notpart2);

endmodule