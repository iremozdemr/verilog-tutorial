module full_adder(
    input A,
    input B,
    input Cin,
    output Cout,
    output S
);

xor G1 (S,A,B,Cin);

wire wire1;
and And1 (wire1,A,B);

wire wire2;
and And2 (wire2,A,Cin);

wire wire3;
and And3 (wire3,B,Cin);

or Result (Cout,wire1,wire2,wire3);

endmodule