module three_to_eight_decoder (
    input A,
    input B,
    input C,
    output Y0,
    output Y1,
    output Y2,
    output Y3,
    output Y4,
    output Y5,
    output Y6,
    output Y7
);

wire notA;
wire notB;
wire notC;

not(notA,A);
not(notB,B);
not(notC,C);

and (Y0, notA, notB, notC);  // 000 -> Y0 = 1
and (Y1, notA, notB, C);     // 001 -> Y1 = 1
and (Y2, notA, B, notC);     // 010 -> Y2 = 1
and (Y3, notA, B, C);        // 011 -> Y3 = 1
and (Y4, A, notB, notC);     // 100 -> Y4 = 1
and (Y5, A, notB, C);        // 101 -> Y5 = 1
and (Y6, A, B, notC);        // 110 -> Y6 = 1
and (Y7, A, B, C);           // 111 -> Y7 = 1

endmodule