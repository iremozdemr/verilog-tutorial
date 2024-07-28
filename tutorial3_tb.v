module tutorial3_tb;

reg a;
reg b;
reg c;
wire d;
wire e;

tutorial3 uut(
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .e(e)
);

initial begin
    $monitor("time: %0d, a: %b, b: %b, c: %b, d: %b, e: %b", $time, a, b, c, d, e);
    a = 0;
    b = 0;
    c = 0;
    #100; 
    a = 1;
    b = 1;
    c = 1;
    #100;
    a = 0;
    b = 0;
    c = 1;
    #100;
    a = 0;
    b = 1;
    c = 0;
    #100;
    a = 0;
    b = 1;
    c = 1;
    #100;
    a = 1;
    b = 0;
    c = 0;
    #100;
    a = 1;
    b = 0;
    c = 1;
    #100;
    a = 1;
    b = 1;
    c = 0;
    #100;
    $finish; 
end

endmodule