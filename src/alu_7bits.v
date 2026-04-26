module alu_7bits(
    input  rst_n,
    input  clk,
    input  bit_in,
    input  [2:0] op,
    
    output [6:0] data_out,
    output done
);


    wire shift_A;
    wire shift_B;
    wire load_result;

 
    controlpath u_control (
        .clk(clk),
        .rst_n(rst_n),
        .shift_A(shift_A),
        .shift_B(shift_B),
        .load_result(load_result),
        .Done(done)
    );

   
    datapath u_datapath (
        .clk(clk),
        .rst_n(rst_n),
        .serial_in(bit_in),
        .shift_A(shift_A),
        .shift_B(shift_B),
        .load_result(load_result),
        .op(op),
        .Data_out(data_out)
    );

endmodule