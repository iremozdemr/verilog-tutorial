module bib3_tb;
    reg [8:0] buyruk;
    wire [3:0] sonuc;

    //test edilecek bib3 modülü örneği
    bib3 uut (
        .buyruk(buyruk),
        .sonuc(sonuc)
    );

    initial begin
        //test topla
        buyruk = {3'b000, 3'b011, 3'b101}; 
        #10; // 10 birim zaman bekle
        $display("topla: %b", sonuc);

        //test çıkar
        buyruk = {3'b001, 3'b011, 3'b001}; 
        #10;
        $display("çıkar: %b", sonuc);

        //test bitwise and
        buyruk = {3'b010, 3'b110, 3'b011}; 
        #10;
        $display("bitwise and: %b", sonuc);

        //test bitwise or
        buyruk = {3'b011, 3'b110, 3'b001}; 
        #10;
        $display("bitwise or: %b", sonuc);

        //test and_r
        buyruk = {3'b100, 3'b111, 3'b000}; 
        #10;
        $display("and_r: %b", sonuc);

        //test or_r
        buyruk = {3'b101, 3'b101, 3'b000}; 
        #10;
        $display("or_r: %b", sonuc);

        //test çift eşlik
        buyruk = {3'b110, 3'b101, 3'b000}; 
        #10;
        $display("çift eşlik: %b", sonuc);

        //test tek eşlik
        buyruk = {3'b111, 3'b101, 3'b000}; 
        #10;
        $display("tek eşlik: %b", sonuc);

        $finish;
    end
endmodule