module two_to_four_decoder(
    input A,
    input B,
    output Y0,
    output Y1,
    output Y2,
    output Y3
);

wire notA;
wire notB;

not(notA,A);
not(notB,B);

and(Y0,notA,notB);  // 00 -> Y0 = 1
and(Y1,notA,B);     // 01 -> Y1 = 1
and(Y2,A,notB);     // 10 -> Y2 = 1
and(Y3,A,B);        // 11 -> Y3 = 1

endmodule