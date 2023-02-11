module counter_module (
    input clock, output reg [4:0] address
);
    always @(posedge clock) begin
        if (address == 31) begin
            address = 0;
        end else begin
            address = address + 1;
        end
    end
endmodule
