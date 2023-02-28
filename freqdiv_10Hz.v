module freqdiv_10HZ(clk,
                    clk_10HZ
);

input clk;
output clk_10HZ;

reg clk_10HZ;
reg [26:0] count_temp;
reg [26:0] count;

always @ (*) begin
    count_temp = count + 1'b1;
end

always @ (posedge clk) begin
    if (count == 27'd4999999) begin
        count <= 27'd0;
        clk_10HZ <= ~clk_10HZ;
    end else begin
        count <= count_temp;
    end
end
    
endmodule