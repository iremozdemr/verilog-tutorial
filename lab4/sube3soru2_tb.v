module sube3soru2_tb;
    reg [9:0] bolunen; //10 bit bölünen (8.2 formatında)
    reg [5:0] bolen;   //6 bit bölen
    wire [3:0] birler; //birler basamağı
    wire [3:0] ondalik1; //ondalık 1. basamak
    wire [3:0] ondalik2; //ondalık 2. basamak

    //test edilecek modül örneği
    sube3soru2 uut (
        .bolunen(bolunen),
        .bolen(bolen),
        .birler(birler),
        .ondalik1(ondalik1),
        .ondalik2(ondalik2)
    );

    initial begin
        //test 1
        bolunen = 10'b0000011001; // 6.25
        bolen = 6'b000011; // 3
        #10;
        $display("test 1: %d.%d%d", birler, ondalik1, ondalik2); // Beklenen Çıkış: 2.08

        //test 2
        bolunen = 10'b0011110000; // 60.00
        bolen = 6'b000100; // 4
        #10;
        $display("test 2: %d.%d%d", birler, ondalik1, ondalik2); // Beklenen Çıkış: 15.00

        //test 3
        bolunen = 10'b0101100000; // 88.00
        bolen = 6'b001000; // 8
        #10;
        $display("test 3: %d.%d%d", birler, ondalik1, ondalik2); // Beklenen Çıkış: 11.00

        //test 4
        bolunen = 10'b0001100100; // 12.50
        bolen = 6'b000101; // 5
        #10;
        $display("test 4: %d.%d%d", birler, ondalik1, ondalik2); // Beklenen Çıkış: 2.50

        //test 5
        bolunen = 10'b0010100100; // 20.50
        bolen = 6'b000010; // 2
        #10;
        $display("test 5: %d.%d%d", birler, ondalik1, ondalik2); // Beklenen Çıkış: 10.25

        $finish;
    end
endmodule