module dflipflop(
    input d,
    input clock,
    output reg q,
    output reg q_not
);

always @(posedge clock) begin
    q <= d;
    q_not <= ~d;
end

endmodule