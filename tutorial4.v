module tutorial4(
    input a,
    input b,
    input c,
    output reg d,
    output reg e
);

initial d = 0;
//d'nin başlangıç değeri belirlenir

always @(a,b,c) 
begin
    d <= a & b;
    e <= d & c;
    //non blocking assignment
    //d'yi bulma ve e'yi bulma işlemlerini aynı anda yapar
    //e'yi bulurken d'nin eski değerini kullanır
end

endmodule