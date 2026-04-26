module controlpath(
    input  clk,
    input  rst_n,

    output reg  shift_A,
    output reg  shift_B,
    output reg  load_result,
    output reg  Done
);

    localparam ST_LOAD_A  = 3'd0;
    localparam ST_LOAD_B  = 3'd1;
    localparam ST_EXECUTE = 3'd2;
    localparam ST_DONE    = 3'd3;

    reg [2:0] state;
    reg [3:0] bit_count;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= ST_LOAD_A;
            bit_count <= 4'd0;
        end
        else begin
            case (state)
                ST_LOAD_A: begin
                    if (bit_count == 4'd6)
                        state <= ST_LOAD_B;
                    bit_count <= bit_count + 4'd1;
                end

                ST_LOAD_B: begin
                    if (bit_count == 4'd13)
                        state <= ST_EXECUTE;
                    bit_count <= bit_count + 4'd1;
                end

                ST_EXECUTE: begin
                    state <= ST_DONE;
                end

                ST_DONE: begin
                    state <= ST_DONE;
                end

                default: begin
                    state     <= ST_LOAD_A;
                    bit_count <= 4'd0;
                end
            endcase
        end
    end

    always @* begin
        shift_A     = 1'b0;
        shift_B     = 1'b0;
        load_result = 1'b0;
        Done        = 1'b0;

        case (state)
            ST_LOAD_A:   shift_A     = 1'b1;
            ST_LOAD_B:   shift_B     = 1'b1;
            ST_EXECUTE:  load_result = 1'b1;
            ST_DONE:     Done        = 1'b1;
        endcase
    end

endmodule