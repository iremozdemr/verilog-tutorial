module coklayici_4x1(
    input [3:0] A,
    input [1:0] S,
    output B
);

wire [3:0] Y;

//E degerine 1 verdim cunku islemlerimin sonuclarini etkilemesini istemedim
kodcozucu_2x4 k1(
    .A(S),
    .E(1'b1),
    .B(Y)
);

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//kodumun matematiksel aciklamasi bu sekildedir:

//B = A[0].Y[0] + A[1].Y[1] + A[2].Y[2] + A[3].Y[3]
//Y[0] = S[1]'.S[0]'
//Y[1] = S[1]'.S[0]
//Y[2] = S[1].S[0]'
//Y[3] = S[1].S[0]

wire wire1;
and (wire1,A[0],Y[0]);

wire wire2;
and (wire2,A[1],Y[1]);

wire wire3;
and (wire3,A[2],Y[2]);

wire wire4;
and (wire4,A[3],Y[3]);

or (B,wire1,wire2,wire3,wire4);

endmodule