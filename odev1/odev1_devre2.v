module odev1_devre(
    input A,
    input B,
    output F,
    output Q
);

wire wire1;
and(wire1,A,B);

wire wire2;
not(wire2,wire1);

xor(F,wire2,1'b0);

wire wire3;
or(wire3,A,1'b1);

nand(Q,wire3,B);

endmodule