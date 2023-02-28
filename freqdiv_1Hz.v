module freqdiv_1HZ(clk,
                   clk_1HZ
);

input clk;
output clk_1HZ;

reg clk_1HZ;
reg [25:0] cnt;
reg [25:0] cnt_temp;

always @ (*) begin
    cnt_temp = cnt + 1'b1;
end

always @ (posedge clk) begin
    if (cnt == 26'd4999999) begin
        cnt <= 26'd0;
        clk_1HZ <= ~clk_1HZ;
    end else begin
        cnt <= cnt_temp;
    end
end

endmodule       