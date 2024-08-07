`timescale 1ns / 1ps

module matriscarpici #(parameter M=8)(
    input clk,
    input rst,
    input [M-1:0] matris_veri,
    input matris_gecerli,
    output reg [2*M+1:0] carpim_veri = 0, // carpimdan 2*M bit ve 2*M bitlik 4 sayı --> max 4 ile carpilir demek yani 2 bit kayar demek, max 2M+2 bit
    output reg carpim_gecerli = 0
    );
    
    reg [M-1:0] A_matrisi [7:0];
    reg [M-1:0] B_matrisi [7:0];
    
    reg [2*M+1:0] carpim_veri_sonraki = 0;
    reg carpim_gecerli_sonraki = 0;
    
    reg [4:0] sayac = 0;
    reg [4:0] sayac_sonraki = 0;
    
    reg [1:0] sayac2 = 0;
    reg [1:0] sayac2_sonraki = 0;
    
    always @* begin
        sayac_sonraki = sayac;
        sayac2_sonraki = sayac2;
        
        carpim_veri_sonraki = 0;
        carpim_gecerli_sonraki = 0;
        
        if(matris_gecerli && sayac < 16) begin
            sayac_sonraki = sayac + 1;
        end
        
        if(sayac == 16) begin // islem yap ve ver
            sayac2_sonraki = sayac2 + 1;
            
            case(sayac2)
                2'b00: begin
                    carpim_veri_sonraki = A_matrisi[0]*B_matrisi[0] + A_matrisi[1]*B_matrisi[2] 
                                        + A_matrisi[2]*B_matrisi[4] + A_matrisi[3]*B_matrisi[6];
                    carpim_gecerli_sonraki = 1;
                end
                2'b01: begin
                    carpim_veri_sonraki = A_matrisi[0]*B_matrisi[1] + A_matrisi[1]*B_matrisi[3] 
                                        + A_matrisi[2]*B_matrisi[5] + A_matrisi[3]*B_matrisi[7];
                    carpim_gecerli_sonraki = 1;
                end
                2'b10: begin
                    carpim_veri_sonraki = A_matrisi[4]*B_matrisi[0] + A_matrisi[5]*B_matrisi[2] 
                                        + A_matrisi[6]*B_matrisi[4] + A_matrisi[7]*B_matrisi[6];
                    carpim_gecerli_sonraki = 1;
                end
                2'b11: begin
                    carpim_veri_sonraki = A_matrisi[4]*B_matrisi[1] + A_matrisi[5]*B_matrisi[3] 
                                        + A_matrisi[6]*B_matrisi[5] + A_matrisi[7]*B_matrisi[7];
                    carpim_gecerli_sonraki = 1;
                    
                    sayac_sonraki = 0;
                    sayac2_sonraki = 0;
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if(rst) begin
            sayac <= 0;
            sayac2 <= 0;
            
            carpim_veri <= 0;
            carpim_gecerli <= 0;
        end
        else begin
            if(matris_gecerli && sayac < 16) begin // matrisleri doldur
                if(sayac[3] == 0) begin
                    A_matrisi[sayac[2:0]] = matris_veri;
                end
                else begin
                    B_matrisi[sayac[2:0]] = matris_veri;
                end
            end
            
            sayac <= sayac_sonraki;
            sayac2 <= sayac2_sonraki;
            
            carpim_veri <= carpim_veri_sonraki;
            carpim_gecerli <= carpim_gecerli_sonraki;
        end
    end
    
endmodule