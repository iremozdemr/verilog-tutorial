module adder_using_full_adder #(parameter width = 5)(
    input [width-1:0] A,
    input [width-1:0] B,
    input Cin,
    output [width-1:0] Cout,
    output [width-1:0] S
);

genvar i;

generate
    for (i=0; i<width ; i=i+1) begin
        full_adder fa(
            .A(A[i]),
            .B(B[i]),
            .Cin((i == 0) ? Cin : Cout[i-1]),
            .Cout(Cout[i]),
            .S(S[i])
        );
    end
endgenerate

endmodule