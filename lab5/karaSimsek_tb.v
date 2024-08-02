module karaSimsek_tb;

    reg saat;               
    wire [7:0] ledler;     

    karaSimsek uut (
        .saat(saat),
        .ledler(ledler)
    );

    initial begin
        saat = 0;
        forever #5 saat = ~saat; 
    end

    initial begin
        #10 $display("zaman: %0d, led'ler: %b", $time, ledler);
        #10 $display("zaman: %0d, led'ler: %b", $time, ledler);
        #10 $display("zaman: %0d, led'ler: %b", $time, ledler);
        #10 $display("zaman: %0d, led'ler: %b", $time, ledler);
        #10 $display("zaman: %0d, led'ler: %b", $time, ledler);
        #10 $display("zaman: %0d, led'ler: %b", $time, ledler);
        #10 $display("zaman: %0d, led'ler: %b", $time, ledler);
        #10 $display("zaman: %0d, led'ler: %b", $time, ledler);
        #10 $display("zaman: %0d, led'ler: %b", $time, ledler);
        #10 $display("zaman: %0d, led'ler: %b", $time, ledler);
        #10 $display("zaman: %0d, led'ler: %b", $time, ledler);
        #10 $display("zaman: %0d, led'ler: %b", $time, ledler);
        
        $finish;
    end

    always @(posedge saat) begin
        $display("zaman: %0d, led'ler: %b", $time, ledler);
    end

endmodule