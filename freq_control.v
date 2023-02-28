module freq_control(clk,
                    clk_ctl
);

input clk;
output [1:0] clk_ctl;

reg [1:0] clk_ctl;
reg [11:0] cnt_l;
reg [13:0] cnt_temp;

always @ (*) begin
    cnt_temp = {clk_ctl, cnt_l} + 1'b1;
end

always @ (posedge clk) begin
    {clk_ctl, cnt_l} <= cnt_temp;
end

endmodule