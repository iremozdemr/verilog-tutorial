module hammingbenzer4bit(
    input  [3:0] A,
    input  [3:0] B,
    output [2:0] HB
);

wire bit_match0, bit_match1, bit_match2, bit_match3;

//compare each bit of A and B
xnor (bit_match0, A[0], B[0]);
xnor (bit_match1, A[1], B[1]);
xnor (bit_match2, A[2], B[2]);
xnor (bit_match3, A[3], B[3]);

//sum the matches to get the hamming similarity
wire [3:0] match_sum;
wire carry_out;
toplayici4bit adder(
    .A({1'b0, bit_match3, bit_match2, bit_match1}),
    .B({1'b0, 1'b0, 1'b0, bit_match0}),
    .Cin(1'b0),
    .S(match_sum),
    .Cout(carry_out)
);

assign HB = match_sum[2:0];

endmodule