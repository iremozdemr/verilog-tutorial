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

module iki_bit_carpici(
    input [1:0] A,
    input [1:0] B,
    output [3:0] C
);

and(C[0],A[0],B[0]);

wire X;

half_adder h1(
    .A(A[0] & B[1]),
    .B(A[1] & B[0]),
    .S(C[1]),
    .Cout(X)
);

half_adder h2(
    .A(A[1] & B[1]),
    .B(X),
    .S(C[2]),
    .Cout(C[3])
);

endmodule