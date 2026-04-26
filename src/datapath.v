module datapath(
    input  clk,
    input  rst_n,
    input  serial_in,
    
    input  shift_A,
    input  shift_B,
    input  load_result,
    input  [2:0] op,

    output reg [6:0] Data_out
    );
    
    
    wire [6:0] A;
    wire [6:0] B;
    wire [6:0] alu_result;

    
    sipo7 sipo_A (
        .clk(clk),
        .rst_n(rst_n),
        .shift_en(shift_A),
        .serial_in(serial_in),
        .data_out(A)
    );

    
    sipo7 sipo_B (
        .clk(clk),
        .rst_n(rst_n),
        .shift_en(shift_B),
        .serial_in(serial_in),
        .data_out(B)
    );

   
    alu_core alu (
        .A(A),
        .B(B),
        .op(op),
        .Data_out(alu_result)
    );

   
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            Data_out <= 7'b0;
        else if (load_result)
            Data_out <= alu_result;
    end
    
endmodule
