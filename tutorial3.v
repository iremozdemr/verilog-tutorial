module tutorial3(
    input a,
    input b,
    input c,
    output reg d,
    output reg e

    //output d,
    //output e
    //yazmak yanlıştır

    //always bloğunun içinde input'lara atama yapılamaz
    //always bloğunun içinde output'lara atama yapılamaz
    //always bloğunun içinde output reg'lere atama yapılabilir
    //always bloğunun içinde reg'lere atama yapılabilir

    //input -> wire
    //output -> wire
    //output reg -> reg
);

//parantezin içine a yazılırsa:
//a her değiştiğinde always bloğundaki işlemler yapılır
always @(a,b,c) 
begin
    d = a & b;
    e = d & c;
    //blocking assignment
    //önce d'nin değerini bulur
    //sonra d'yi kullanarak e'yi bulur

    //d <= a | b;
    //e <= d | c;
    //non blocking assignment
    //d'yi bulma ve e'yi bulma işlemlerini aynı anda yapar
    //e'yi bulurken d'nin eski değerini kullanır
end

endmodule