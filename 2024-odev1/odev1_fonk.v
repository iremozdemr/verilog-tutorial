module odev1_devre(
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
wire notE;

not(notA,A);
not(notB,B);
not(notC,C);
not(notE,E);

// wire1 = A'BCDE'
wire wire1;
and(wire1,notA,B,C,D,notE);

// wire2 = CE'
wire wire2;
and(wire2,C,notE);

//part1 = A'BCDE'+CE'+A
wire part1;
or(part1,wire1,wire2,A);

//wireX = C'ED
wire wireX;
and(wireX,notC,E,D);

//wireY = AB'CDE'
wire wireY;
and(wireY,A,notB,C,D,notE);

//part2 = B+C'ED+AB'CDE'
wire part2;
or(part2,B,wireX,wireY);

//notpart2 = (B+C'ED+AB'CDE')'
wire notpart2;
not(notpart2,part2);

//F = (A'BCDE'+CE'+A)+(B+C'ED+AB'CDE')'
or(F,part1,notpart2);

endmodule