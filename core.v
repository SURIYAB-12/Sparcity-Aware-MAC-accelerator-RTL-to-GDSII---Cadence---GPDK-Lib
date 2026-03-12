
module sa_mac_core #(
    parameter DATA_W = 8,
    parameter ACC_W  = 32
)(
    input clk,
    input rst_n,

    // Control
    input valid,
    input zero_skip_enable,

    // Signed INT8 operands
    input  signed [DATA_W-1:0] a,
    input  signed [DATA_W-1:0] b,

    // Signed accumulator output
    output reg signed [ACC_W-1:0] acc,

    // Skip indicator
    output reg skipped
);

    // Signed product (INT8 × INT8 = 16 bits)
    wire signed [2*DATA_W-1:0] product;

    // Combinational multiply
    assign product = a * b;

    // Sequential accumulation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc     <= 0;
            skipped <= 1'b0;
        end
        else begin
            skipped <= 1'b0;

            if (valid) begin
                // Zero-skip condition
                if (zero_skip_enable && ((a == 0) || (b == 0))) begin
                    skipped <= 1'b1;
                end
                else begin
                    acc <= acc + product;
                end
            end
        end
    end

endmodule