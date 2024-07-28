module tutorial2_tb;

reg a;
reg b;

wire y;

tutorial2 uut(
    .a(a),
    .b(b),
    .y(y)
);

initial begin
    a = 0;
    b = 0;

    #100;
end

endmodule