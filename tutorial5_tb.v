module tutorial5_tb;

reg [3:0] d0;
reg [3:0] d1;
reg select;

wire [3:0] y;

tutorial5 uut(
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
    d0 = 4;
    d1 = 6;
    select = 0;
    #100;
    d0 = 3;
    d1 = 4;
    select = 1;
    #100;
    $finish;
end

endmodule