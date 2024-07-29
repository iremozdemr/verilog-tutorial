module clock_divider(
    input clock_in,
    output reg clock_out
);

integer count;
initial count = 0;

initial clock_out = 0;

always @(posedge clock_in) begin
    count = count + 1;

    if (count == 4) begin
        clock_out = ~clock_out;
        count = 1;
    end

end

endmodule