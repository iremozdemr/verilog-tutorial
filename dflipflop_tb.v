module dflipflop_tb;

reg d;
reg clock;

wire q;
wire q_not;

dflipflop uut(
    .d(d),
    .clock(clock),
    .q(q),
    .q_not(q_not)
);

initial begin
    $monitor("time: %0d, d: %b, clock: %b, q: %b, q_not: %b", $time,d,clock,q,q_not);
    clock = 0;
    d = 0;
    #100
    d = 1;
    #15
    d = 0;
    #15
    d = 0;
    #15
    d = 1;
    #15
    d = 0;
    #15
    $finish;
end

always #10 clock = ~clock;
//her 10 saniyede clock sinyali değişir

endmodule