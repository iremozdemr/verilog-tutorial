//half adder start
module half_adder(
    input A,
    input B,
    output S,
    output Cout
);

xor G1 (S,A,B);
and G2 (C,A,B);

endmodule
//half adder end

module full_adder_using_half_adder(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
);

wire s1;
wire cout1;

half_adder H1(
    .A (A),
    .B (B),
    .S (sum1),
    .Cout (cout1)
);

wire cout2;

half_adder H2(
    .A (sum1),
    .B (Cin),
    .S (S),
    .Cout (cout2)
);

or(Cout,cout1,cout2);

endmodule