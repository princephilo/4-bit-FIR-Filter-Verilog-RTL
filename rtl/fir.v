`timescale 1ns/1ns

module fir(
    x, h0, h1, h2, h3, y, rst, clk
);

input wire [3:0] x;
input wire [3:0] h0, h1, h2, h3;
input wire rst, clk;

output wire [9:0] y;

reg [3:0] x0, x1, x2, x3;

always @(posedge clk) begin
    if (rst) begin
        x0 <= 4'd0;
        x1 <= 4'd0;
        x2 <= 4'd0;
        x3 <= 4'd0;
    end
    else begin
        x0 <= x;
        x1 <= x0;
        x2 <= x1;
        x3 <= x2;
    end
end

assign y = (h0 * x0) + (h1 * x1) + (h2 * x2) + (h3 * x3);

endmodule
