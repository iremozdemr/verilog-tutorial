module multiplexer_2_1_tb;

reg [1:0] mux_input;
reg select;

wire  mux_output;

multiplexer_2_1 uut(
    .mux_input(mux_input),
    .select(select),
    .mux_output(mux_output)
);

initial begin
    $monitor("time: %0d, mux_input: %b, select: %b, mux_output: %b", $time, mux_input,select,mux_output);
    mux_input = 2'b00;
    select = 0;
    #100
    mux_input = 2'b01;
    select = 0;
    #100
    mux_input = 2'b00;
    select = 1;
    #100
    mux_input = 2'b10;
    select = 1;
    #100
    $finish; 
end

endmodule