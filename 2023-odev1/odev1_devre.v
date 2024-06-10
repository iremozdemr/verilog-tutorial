module odev1_devre(
    input A,
    input B,
    input C,
    output F,
    output Q
);

wire notA;
wire bufC;

not (notA,A);
buf (bufC,C);

wire wire1;
xnor (wire1,notA,B);

wire wire2;
and (wire2,wire1,bufC);

wire wire3;
or (wire3,bufC,1'b0);

wire wire4;
xor (wire4,wire2,wire3);

nor (Q,wire2,wire3);

nand (F,wire4,Q);

endmodule