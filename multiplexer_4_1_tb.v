module multiplexer_4_1_tb;

reg [3:0] mux_input;
reg [2:0] select;

wire  mux_output;

multiplexer_4_1 uut(
    .mux_input(mux_input),
    .select(select),
    .mux_output(mux_output)
);

initial begin
    $monitor("time: %0d, mux_input: %b, select: %b, mux_output: %b", $time, mux_input,select,mux_output);
    mux_input = 4'b0000;
    select = 2'b00;
    #100
    mux_input = 4'b0001;
    select = 2'b00;
    #100
    mux_input = 4'b0000;
    select = 2'b11;
    #100
    mux_input = 4'b1001;
    select = 2'b11;
    #100
    $finish; 
end

endmodule