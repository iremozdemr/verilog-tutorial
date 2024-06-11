module kodcozucu_2x4(
    input [1:0] A,
    input E,
    output [3:0] B
);

wire notA0;
wire notA1;

not (notA0,A[0]);
not (notA1,A[1]);

//B[0] = E.A[1]'.A[0]'
and (B[0],E,notA1,notA0);

//B[1] = E.A[1]'.A[0]
and (B[1],E,notA1,A[0]);

//B[2] = E.A[1].A[0]'
and (B[2],E,A[1],notA0);

//B[3] = E.A[1].A[0]
and (B[3],E,A[1],A[0]);

endmodule