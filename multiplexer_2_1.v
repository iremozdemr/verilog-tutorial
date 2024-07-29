module multiplexer_2_1(
    input [1:0] mux_input,
    input select,
    output reg mux_output
    //always bloğunun içinde mux_output'a atama yapıldığı için
    //mux_output reg yapılmalıdır
);

always @(select,mux_input) begin
    case (select)
        0 : mux_output = mux_input[0];
        1 : mux_output = mux_input[1];
    endcase
end

endmodule