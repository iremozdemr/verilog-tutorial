module konvolusyon_birimi (
    input saat, 
    input reset, 
    input basla, 
    input [127:0] matris, 
    input [71:0] filtre, 

    output reg [127:0] sonuc, 
    output reg hazir
);

integer i;
integer j;
//for döngüleri için i ve j değişkenleri oluşturdum
reg [3:0] durum;
reg [7:0] matris_reg [0:15]; 
//4x4 matris
reg [7:0] filtre_reg [0:8]; 
//3x3 filtre
reg [7:0] sonuc_reg;

//başlangıç durumlarını 0 olarak atadım
initial begin
    i = 0;
    j = 0;
    hazir = 0;
    durum = 0;
    sonuc = 0;
    sonuc_reg = 0;
end

always @(posedge saat) begin
    if (reset) begin
        //devreyi resetleme işlemi
        hazir <= 0;
        durum <= 0;
        sonuc <= 0;
    end
    else if (basla) begin
        for (i = 0; i < 16; i = i + 1) begin
            matris_reg[i] <= matris[(127 - 8 * i) -: 8];
        end
        //128 bitlik matris girişinden 8 bitlik değerleri aldım

        for (i = 0; i < 9; i = i + 1) begin
            filtre_reg[i] <= filtre[(71 - 8 * i) -: 8];
        end
        //72 bitlik filtre girişinden 8 bitlik değerleri aldım
        durum <= 1;
    end
end

//konvolusyon işlemi için kodlar:
always @(posedge saat) begin
    if (durum > 0 && durum < 17) begin
        sonuc_reg = 0;
        for (i = 0; i < 3; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin
                if ((durum / 4 + i - 1) >= 0) begin
                    if ((durum / 4 + i - 1) < 4) begin
                        if ((durum % 4 + j - 1) >= 0) begin
                            if ((durum % 4 + j - 1) < 4) begin
                                sonuc_reg = sonuc_reg + matris_reg[(durum / 4 + i - 1) * 4 + (durum % 4 + j - 1)] * filtre_reg[i * 3 + j];
                                //matris elemanlarını ve filtre elemanlarını çarpıp toplama ekledim
                            end
                        end
                    end
                end
            end
        end
        sonuc[(127 - 8 * (durum - 1)) -: 8] <= sonuc_reg;
        //(127 - 8 * (durum - 1)) konumundan başlayarak 8 bitlik bir aralık seçilir
        durum <= durum + 1;
    end
    else if (durum == 17) begin
        hazir <= 1;
        durum <= 0; 
    end
end

endmodule