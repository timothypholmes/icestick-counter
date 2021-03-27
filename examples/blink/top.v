module top(input clk, 
           output D1, 
           output D2, 
           output D3,
           output D4,
           output D5);

reg ready = 0;
reg [23:0] divider;
reg led;

always @(posedge clk)
begin
    if (ready)
    begin
        if (divider == 12000000)
        begin
            divider <= 0;
            led <= !led;
        end
        else
            divider <= divider + 1;
    end
    else
    begin
        ready <= 1;
        divider <= 0;
    end
end

assign D1 = led;
assign D2 = led;
assign D3 = led;
assign D4 = led;
assign D5 = !led;

endmodule