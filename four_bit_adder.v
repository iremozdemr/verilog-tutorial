//full adder start
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
//full adder end

module four_bit_adder(
    input [3:0] A,
    input [3:0] B,
    input C0,
    output [3:0] S,
    output C4
);

wire C1;
wire C2;
wire C3;

full_adder f0(
    .A(A[0]),
    .B(B[0]),
    .Cin(C0),
    .Cout(C1),
    .S(S[0])
);

full_adder f1(
    .A(A[1]),
    .B(B[1]),
    .Cin(C1),
    .Cout(C2),
    .S(S[1])
);

full_adder f2(
    .A(A[2]),
    .B(B[2]),
    .Cin(C2),
    .Cout(C3),
    .S(S[2])
);

full_adder f3(
    .A(A[3]),
    .B(B[3]),
    .Cin(C3),
    .Cout(C4),
    .S(S[3])
);

endmodule