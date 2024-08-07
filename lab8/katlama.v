module katlama(
    input clk,
    input [15:0] kuru_camasir,
    input basla,
    output reg bitti,
    output reg [3:0] cikis
);

always @(posedge clk) begin
    if (basla) begin
        cikis[3] = |kuru_camasir[15:12];
        cikis[2] = |kuru_camasir[11:8];
        cikis[1] = |kuru_camasir[7:4];
        cikis[0] = |kuru_camasir[3:0];
        bitti = 1;
    end else begin
        bitti = 0;
    end
end

endmodule