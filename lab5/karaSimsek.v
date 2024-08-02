module karaSimsek(
    input saat,
    output reg [7:0] ledler
);

reg yon;

initial ledler = 8'b00000111;
initial yon = 1'b0;
//yon = 0 ise sola git
//yon = 1 ise sağa git

always @(negedge saat) begin
    if (yon == 1'b0) begin
        if (ledler == 8'b11100000) begin
            yon <= 1'b1;
        end
        if (ledler != 8'b11100000) begin
            ledler <= ledler << 1;
        end
    end
    else begin
        if (ledler == 8'b00000111) begin
            yon <= 1'b0;
        end
        if (ledler != 8'b00000111) begin
            ledler <= ledler >> 1;
        end
    end      
end

endmodule