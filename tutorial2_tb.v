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
    $monitor("time: %0d, a: %b, b: %b, y: %b", $time, a, b, y); //çıktı için monitor kullanımı
    a = 0;
    b = 0;
    #100; //100 zaman birimi bekle
    a = 1;
    b = 0;
    #100;
    a = 0;
    b = 1;
    #100;
    a = 1;
    b = 1;
    #100;
    $finish; //simülasyonu bitir
end

endmodule