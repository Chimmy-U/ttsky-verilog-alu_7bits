module alu_core #(
    parameter WIDTH = 7
)(
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire [2:0]       op,
    output reg  [WIDTH-1:0] Data_out
);

    localparam OP_ADD = 3'b000;
    localparam OP_AND = 3'b001;
    localparam OP_OR  = 3'b010;
    localparam OP_XOR = 3'b011;
    localparam OP_SUB = 3'b100;
    localparam OP_INC = 3'b101;
    localparam OP_DEC = 3'b110;

    wire [WIDTH-1:0] ONE = {{(WIDTH-1){1'b0}}, 1'b1};
    wire is_sub = (op == OP_SUB) || (op == OP_DEC);

    wire [WIDTH-1:0] arith_operand =
        (op == OP_INC || op == OP_DEC) ? ONE : B;

    wire [WIDTH-1:0] arith_term = is_sub ? ~arith_operand : arith_operand;
    wire [WIDTH:0]   arith_sum  = {1'b0, A} + {1'b0, arith_term} + is_sub;

    always @* begin
        case (op)
            OP_ADD,
            OP_SUB,
            OP_INC,
            OP_DEC: Data_out = arith_sum[WIDTH-1:0];

            OP_AND: Data_out = A & B;
            OP_OR : Data_out = A | B;
            OP_XOR: Data_out = A ^ B;

            default: Data_out = {WIDTH{1'b0}};
        endcase
    end

endmodule