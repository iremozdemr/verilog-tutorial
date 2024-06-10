module odev1_devre(
    input A,
    input B,
    input C,
    output F,
    output Q
);

wire bufferA;
buf(bufferA,A);

wire notC;
not(notC,C);

wire wire1;
or(wire1,bufferA,B);

wire wire2;
xor(wire2,wire1,notC);

wire wire3;
nor(wire3,wire1,wire2);

and(Q,notC,1'b1);

nor(F,wire3,Q);

endmodule