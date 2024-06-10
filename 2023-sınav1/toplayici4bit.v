//tamtoplayici baslangic
module tamtoplayici(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
);

wire wire1;
wire wire2;
wire wire3;

and (wire1,A,B);
and (wire2,B,Cin);
and (wire3,A,Cin);

xor (S,A,B,Cin);
or (Cout,wire1,wire2,wire3);

endmodule
//tamtoplayici bitis


module toplayici4bit(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    input [3:0] S,
    output Cout
);

wire Carry1, Carry2, Carry3;
tamtoplayici tt0(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(Carry1));
tamtoplayici tt1(.A(A[1]), .B(B[1]), .Cin(Carry1), .S(S[1]), .Cout(Carry2));
tamtoplayici tt2(.A(A[2]), .B(B[2]), .Cin(Carry2), .S(S[2]), .Cout(Carry3));
tamtoplayici tt3(.A(A[3]), .B(B[3]), .Cin(Carry3), .S(S[3]), .Cout(Cout));

endmodule