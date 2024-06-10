module seyahatdogrula(
    input [3:0] yakit,
    input [5:0] rota,
    output seyahat_dogru
);
    
wire rota_dogru;
rotadogrula rd(.rota(rota), .rota_dogru(rota_dogru));
    
wire yeterli_yakit;
and(yeterli_yakit, yakit[3], yakit[2]);
    
and(seyahat_dogru, rota_dogru, yeterli_yakit);
    
endmodule