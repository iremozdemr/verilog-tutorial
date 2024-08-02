module sube3soru2(
    input [9:0] bolunen,    //10 bit bölünen (8.2 formatında)
    input [5:0] bolen,      //6 bit bölen
    output reg [3:0] birler, //birler basamağı
    output reg [3:0] ondalik1, //ondalık 1. basamak
    output reg [3:0] ondalik2  //ondalık 2. basamak
);

reg [15:0] sonuc; //16 bit sonuç depolama (daha hassas sonuçlar için)
reg [15:0] bolunen_genişletilmiş; //bölünen değerin genişletilmiş hali (ondalık kısmı tam sayı gibi işlem yapabilmek için)

always @(*) begin
    bolunen_genişletilmiş = bolunen * 100; //8.2 formatında olduğundan, 100 ile çarpılarak ondalık kısmı tam sayı gibi işlem yap
    sonuc = bolunen_genişletilmiş / bolen; //bölme işlemi
    
    birler = sonuc / 100; //birler basamağı
    ondalik1 = (sonuc % 100) / 10; //ondalık 1. basamak
    ondalik2 = sonuc % 10; //ondalık 2. basamak
end

endmodule