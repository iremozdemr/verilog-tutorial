module yerlestirme(
    input clk,
    input [3:0] katlanmis_camasir,
    input basla,
    output reg bitti
);

reg [3:0] hafiza [31:0];
integer i = 0;

always @(posedge clk) begin
    if (basla) begin
        hafiza[i] = katlanmis_camasir;
        i = i+1;
    end
    if (i == 8) begin
        bitti = 1;
    end
end

endmodule