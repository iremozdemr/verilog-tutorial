module fabrika(
    input G,
    input Y,
    input K,
    output [1:0] S
);

//S[0] = G.K + G.Y
wire wire1;
and (wire1,G,K);

wire wire2;
and (wire2,G,Y);

or (S[0],wire1,wire2);

//S[1] = G.K'
wire notK;
not (notK,K);

and (S[1],G,notK);

endmodule