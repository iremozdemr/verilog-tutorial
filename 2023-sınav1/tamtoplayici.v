module tamtoplayici(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
);

//S = A xor B xor Cin
//Cout = AB + BCin + ACin

wire wire1;
wire wire2;
wire wire3;

and (wire1,A,B);
and (wire2,B,Cin);
and (wire3,A,Cin);

xor (S,A,B,Cin);
or (Cout,wire1,wire2,wire3);

endmodule