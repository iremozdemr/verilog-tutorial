module yikama(
    input clk,
    input [15:0] camasir,
    input basla,
    output reg bitti,
    output reg [15:0] cikis
);

always @(posedge clk) begin
    if (basla) begin
        cikis = camasir;
        cikis[15] = 1'b0;
        cikis[11] = 1'b0;
        cikis[7] = 1'b0;
        cikis[3] = 1'b0;
        bitti = 1;
    end 
end

endmodule