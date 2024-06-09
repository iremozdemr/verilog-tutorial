//bit sayısı = bitiş - başlangıç + 1
//[31:0] = [31] [30] ... [0]
//[15:8] = [15] [14] ... [8]

//kod çözücü = decoder
//kodlayıcı = encoder
//çoklayıcı = multiplexer
//tekleyici = demultiplexer

//1. yazım şekli
module tutorial1(
    input a,
    input b,
    input [31:0] c,
    output d
);
    
endmodule

//2. yazım şekli
module tutorial2(a,b,c,d);
    input a;
    input b;
    input [31:0] c,
    output d;
    
endmodule