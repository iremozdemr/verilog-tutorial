module senkron_flipflop(
    input d,
    input clock,
    input reset,
    output reg q,
    output reg q_not
);

always @(posedge clock, posedge reset) begin
    if (reset == 1) begin
        q = 0;
        q_not = 1;
    end
    else begin 
        q = d;
        q_not = ~d;
    end
        
end

endmodule

//reset = 1 olduğunda output sıfırlanır
//senkron reset = reset değiştiğinde hemen output sıfırlanmaz
//asenkron reset = reset değiştiğinde hemen output sıfırlanır