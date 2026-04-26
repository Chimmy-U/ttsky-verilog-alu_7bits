`default_nettype none

module tt_um_alu_7bits (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);


alu_7bits unit_alu_7bits(
    .rst_n(rst_n),
    .clk(clk),
    .bit_in(ui_in[0]),
    .op(ui_in[3:1]),
    
    .data_out(uo_out[6:0]),
    .done(uo_out[7])
);

wire _unused = &{ena, uio_in, 1'b0};

assign uio_out = 8'bz;
assign uio_oe = 8'b0;

endmodule