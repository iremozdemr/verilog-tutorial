module tutorial6_tb;

//module tutorial6_tb #(parameter width = 5)
//yazılabilirdi

reg [4:0] d0;
reg [4:0] d1;
reg select;

wire [4:0] y;

tutorial6 uut(
    .d0(d0),
    .d1(d1),
    .select(select),
    .y(y)
);

initial begin
    $monitor("time: %0d, d0: %b, d1: %b, select: %b, y: %b", $time, d0, d1, select, y); 
    d0 = 0; 
    d1 = 0; 
    select = 0;
    #100;
    d0 = 19;
    d1 = 6;
    select = 0;
    #100;
    d0 = 3;
    d1 = 19;
    select = 1;
    #100;
    $finish;
end

endmodule