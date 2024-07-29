module adder_using_full_adder_tb #(parameter width = 5);

reg [width-1:0] A;
reg [width-1:0] B;
reg Cin;

wire [width-1:0] Cout;
wire [width-1:0] S;

adder_using_full_adder #(width) uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Cout(Cout),
    .S(S)
);

initial begin
    $monitor("time: %0d, A: %b, B: %b, Cin: %b, S: %b, Cout: %b", $time, A, B, Cin, S, Cout);
    
    A = 5'b00001; B = 5'b00001; Cin = 0;
    #10;
    A = 5'b10001; B = 5'b01101; Cin = 1;
    #10;
    A = 5'b11111; B = 5'b11111; Cin = 0;
    #10;
    A = 5'b00000; B = 5'b00001; Cin = 1;
    #10;
    A = 5'b10101; B = 5'b01010; Cin = 0;
    #10;
    $finish;
end

endmodule