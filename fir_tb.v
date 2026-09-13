module fir_tb;

reg [3:0] x;
reg [3:0] h0, h1, h2, h3;
reg rst, clk;

wire [9:0] y;

fir f1(x,h0,h1,h2,h3,y,rst,clk);

initial begin
    clk = 0;
    forever #50 clk = ~clk;
end

initial begin

    h0 = 4'd1;
    h1 = 4'd2;
    h2 = 4'd2;
    h3 = 4'd1;

    rst = 1;
    x = 4'd0;

    #100;
    rst = 0;

    #25 x = 4'd1;
    #100 x = 4'd2;
    #100 x = 4'd3;
    #100 x = 4'd4;

    #200;
    $finish;
end
initial begin
    $monitor("Time=%0t | rst=%b | x=%d | y=%d",
             $time, rst, x, y);
end

endmodule