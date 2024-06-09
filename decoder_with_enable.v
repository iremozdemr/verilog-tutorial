module decoder_with_enable(
    input A,
    input B,
    input Enable,
    output Y0,
    output Y1,
    output Y2,
    output Y3
);

wire notA;
wire notB;

not(notA,A);
not(notB,B);

and(Y0,Enable,notA,notB);   // 00 -> Y0 = 1 if Enable is 1 
and(Y1,Enable,notA,B);      // 01 -> Y1 = 1 if Enable is 1 
and(Y2,Enable,A,notB);      // 10 -> Y2 = 1 if Enable is 1 
and(Y3,Enable,A,B);         // 11 -> Y3 = 1 if Enable is 1 

endmodule