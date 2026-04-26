module sipo7(
    input  clk,
    input  rst_n,
    input  shift_en,
    input  serial_in,
    output reg [6:0] data_out
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            data_out <= 7'b0;
        else if (shift_en)
            data_out <= {serial_in, data_out[6:1]};
    end

endmodule