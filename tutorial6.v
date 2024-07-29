module tutorial6 #(parameter width = 5)(
    input [width-1:0] d0,
    input [width-1:0] d1,
    input select,
    output [width-1:0] y
);

assign y = select ? d1 : d0;

endmodule

//2x1 multiplexer
//select = 0 ise y = d0 olur
//select = 1 ise y = d1 olur

//assign y = s ? d1 : d0
//select doğruysa y = d1
//select yanlışsa y = d0