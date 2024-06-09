module half_adder(
    input A,
    input B,
    output Cout,
    output S;
);

xor G1 (S,A,B);
and G2 (C,A,B);

endmodule