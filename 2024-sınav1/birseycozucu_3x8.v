module birseycozucu_3x8(
    input [2:0] A,
    output [7:0] B
);

wire notA2;

not (notA2,A[2]);

//B[0] B[1] B[2] B[3] degerlerini bulmak icin k1'i yazdim
//bunu yapmamin nedeni ise bunlarda ortak olarak A[2] nin olmasi
kodcozucu_2x4 k1(
    .A(A[1:0]),
    .E(A[2]),
    .B(B[3:0])
);

//B[4] B[5] B[6] B[7] degerlerini bulmak icin k2'yi yazdim
//bunu yapmamin nedeni ise bunlarda ortak olarak notA[2] nin olmasi
kodcozucu_2x4 k2(
    .A(A[1:0]),
    .E(notA2),
    .B(B[7:4])
);

endmodule