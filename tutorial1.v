//bit sayısı = bitiş - başlangıç + 1
//[31:0] = [31] [30] ... [0]
//[15:8] = [15] [14] ... [8]

//kod çözücü = decoder
//kodlayıcı = encoder
//çoklayıcı = multiplexer
//tekleyici = demultiplexer

//komutlar:
//iverilog -o tutorial2_tb.vvp tutorial2_tb.v tutorial2.v
//vvp tutorial2_tb.vvp

//1. yazım şekli
module module1(
    input a,
    input b,
    input [31:0] c,
    output d
);
    
endmodule

//2. yazım şekli
module module2(a,b,c,d);
    input a;
    input b;
    input [31:0] c,
    output d;
    
endmodule