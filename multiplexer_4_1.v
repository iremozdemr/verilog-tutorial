module multiplexer_4_1(
    input [3:0] mux_input,
    input [2:0] select,
    output reg mux_output
    //always bloğunun içinde mux_output'a atama yapıldığı için
    //mux_output reg yapılmalıdır
);

always @(select,mux_input) begin
    case (select)
        2'b00: mux_output = mux_input[0];
        2'b01: mux_output = mux_input[1];
        2'b10: mux_output = mux_input[2];
        2'b11: mux_output = mux_input[3];
    endcase
end

endmodule