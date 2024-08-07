module seven_segment_display_tb;

    reg clk;
    reg [7:0] seconds;
    reg [7:0] minutes;
    reg [7:0] hours;
    wire [7:0] seg;
    wire [3:0] an;

    seven_segment_display uut (
        .clk(clk),
        .seconds(seconds),
        .minutes(minutes),
        .hours(hours),
        .seg(seg),
        .an(an)
    );

    //clock sinyali üretici
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
        //10ns period
    end

    initial begin
        //vcd dosyası oluşturma
        $dumpfile("seven_segment_display_tb.vcd");
        $dumpvars(0, seven_segment_display_tb);

        seconds = 8'd0;
        minutes = 8'd0;
        hours = 8'd0;

        //test 1: 12:34:56
        #100;
        seconds = 8'd56;
        minutes = 8'd34;
        hours = 8'd12;
        #500000;

        //test 2: 23:59:59
        #100;
        seconds = 8'd59;
        minutes = 8'd59;
        hours = 8'd23;
        #500000;

        //test 3: 00:00:00
        #100;
        seconds = 8'd0;
        minutes = 8'd0;
        hours = 8'd0;
        #500000;

        //test 4: 11:11:11
        #100;
        seconds = 8'd11;
        minutes = 8'd11;
        hours = 8'd11;
        #500000;

        //test 5: 07:07:07
        #100;
        seconds = 8'd7;
        minutes = 8'd7;
        hours = 8'd7;
        #500000;

        //test 6: 23:45:56
        #100;
        seconds = 8'd56;
        minutes = 8'd45;
        hours = 8'd23;
        #500000;

        #100 $finish;
    end

    initial begin
        $monitor("time: %0t | hours: %0d, minutes: %0d, seconds: %0d | seg: %b, an: %b",
                 $time, hours, minutes, seconds, seg, an);
    end

endmodule