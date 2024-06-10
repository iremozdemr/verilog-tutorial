module hammingbenzer16bit(
    input  [15:0] A,
    input  [15:0] B,
    output [4:0]  HB
);
    
wire [2:0] HB1;
wire [2:0] HB2;
wire [2:0] HB3;
wire [2:0] HB4;
hammingbenzer4bit hb4b1(.A(A[15:12]), .B(B[15:12]), .HB(HB1));
hammingbenzer4bit hb4b2(.A(A[11:8] ), .B(B[11:8] ), .HB(HB2));
hammingbenzer4bit hb4b3(.A(A[7:4]  ), .B(B[7:4]  ), .HB(HB3));
hammingbenzer4bit hb4b4(.A(A[3:0]  ), .B(B[3:0]  ), .HB(HB4));
    
wire [3:0] S12;
wire [3:0] S34;
toplayici4bit t4b12(.A({1'b0, HB1}), .B({1'b0, HB2}), .Cin(1'b0), .S(S12), .Cout());
toplayici4bit t4b34(.A({1'b0, HB3}), .B({1'b0, HB4}), .Cin(1'b0), .S(S34), .Cout());
    
toplayici4bit t4b1234(.A(S12), .B(S34), .Cin(1'b0), .S(HB[3:0]), .Cout(HB[4]));

endmodule