module kurutma(
    input clk,
    input [15:0] temiz_camasir,
    input basla,
    output reg bitti,
    output reg [15:0] cikis
);

always @(posedge clk) begin
    if (basla) begin
        cikis = ~temiz_camasir;
        bitti = 1;
    end
end
endmodule