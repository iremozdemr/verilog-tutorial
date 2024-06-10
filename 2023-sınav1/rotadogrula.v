module rotadogrula(
    input [5:0] rota,
    output rota_dogru
);
    
wire [5:0] nrota;
not(nrota[5], rota[5]);
not(nrota[4], rota[4]);
not(nrota[3], rota[3]);
not(nrota[2], rota[2]);
not(nrota[1], rota[1]);
not(nrota[0], rota[0]);
    
wire w1, w2, w3, w4;
and(w1, rota[5], rota[4], rota[3], nrota[2], nrota[1], nrota[0]);
and(w2, rota[5], nrota[4], nrota[3], nrota[2], rota[1], rota[0]);
and(w3, rota[5], nrota[4], nrota[3], rota[2], nrota[1], rota[0]);
and(w4, rota[5], nrota[4], nrota[3], rota[2], rota[1], nrota[0]);
    
or(rota_dogru, w1, w2, w3, w4);
    
endmodule