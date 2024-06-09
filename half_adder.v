module half_adder(
    input A,
    input B,
    output S,
    output Cout
);

xor G1 (S,A,B);
and G2 (C,A,B);

endmodule