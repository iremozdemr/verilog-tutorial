module ardisik_konvolusyon_birimi (
    input saat, 
    input reset, 
    input basla, 
    input [127:0] matris, 
    input [71:0] filtre1, 
    input [71:0] filtre2, 

    output [127:0] sonuc, 
    output hazir
);

wire hazir1; 
//ilk konvolüsyon biriminin hazir sinyali
wire [127:0] sonuc1; 
//ilk konvolüsyon biriminin sonucu
reg [5:0] sayac; 
//32 çevrim için oluşturulan sayaç
reg yeni_islem_baslat; 
//yeni işlem başlatma sinyali
reg yeni_islem_izin; 
//yeni işlemi başlatmak için izin sinyali

konvolusyon_birimi uut1 (
    .saat(saat),
    .reset(reset),
    .basla(basla),
    .matris(matris),
    .filtre(filtre1),
    .sonuc(sonuc1),
    .hazir(hazir1)
);

konvolusyon_birimi uut2 (
    .saat(saat),
    .reset(reset),
    .basla(yeni_islem_baslat),
    .matris(sonuc1),
    .filtre(filtre2),
    .sonuc(sonuc),
    .hazir(hazir)
);

initial begin
    sayac = 0;
    yeni_islem_baslat = 0;
    yeni_islem_izin = 0;
end

//reset ve sayaç işlemleri
always @(posedge saat) begin
    if (reset) begin
        sayac <= 0;
        yeni_islem_baslat <= 0;
        yeni_islem_izin <= 0;
    end else begin
        if (basla && yeni_islem_izin) begin
            if (sayac < 32) begin
                sayac <= sayac + 1;
            end
            if (sayac == 15) begin
                yeni_islem_baslat <= 1;
            end
            if (sayac == 31) begin
                yeni_islem_izin <= 0;
            end
        end

        //32. çevrimden sonra sayaç ve hazir sinyalini resetleme
        if (sayac == 32) begin
            sayac <= 0;
        end

        //yeni işlem izni 16 çevrim sonra verilmelidir
        if (sayac == 16) begin
            yeni_islem_izin <= 1;
        end
    end
end

endmodule