
module sa_mac_regs #(
    parameter DATA_W = 8,
    parameter ACC_W  = 32
)(
    input clk,
    input rst_n,

    // Register interface
    input wr_en,
    input rd_en,
    input [5:0] addr,
    input [31:0] wdata,
    output reg [31:0] rdata,

    // To MAC core
    output mac_valid,
    output reg zero_skip_enable,
    output reg signed [DATA_W-1:0] mac_a,
    output reg signed [DATA_W-1:0] mac_b,

    input  signed [ACC_W-1:0] mac_acc,
    input  mac_skipped,

    // Statistics
    output reg [31:0] total_ops,
    output reg [31:0] skipped_ops
);

    reg mac_valid_r;
    reg mac_valid_d;

    // -------------------------------------------------
    // Sequential logic
    // -------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mac_a            <= 0;
            mac_b            <= 0;
            zero_skip_enable <= 1'b1;

            mac_valid_r      <= 1'b0;
            mac_valid_d      <= 1'b0;

            total_ops        <= 32'd0;
            skipped_ops      <= 32'd0;
        end
        else begin
            mac_valid_r <= 1'b0;

            if (wr_en) begin
                case (addr)

                    6'h00: begin
                        zero_skip_enable <= wdata[1];
                    end

                    6'h04: begin
                        mac_a <= wdata[DATA_W-1:0];
                    end

                    6'h08: begin
                        mac_b       <= wdata[DATA_W-1:0];
                        mac_valid_r <= 1'b1;
                    end

                endcase
            end

            mac_valid_d <= mac_valid_r;

            if (mac_valid_d) begin
                total_ops <= total_ops + 1;

                if (mac_skipped)
                    skipped_ops <= skipped_ops + 1;
            end
        end
    end

    assign mac_valid = mac_valid_r;

    // -------------------------------------------------
    // Read logic
    // -------------------------------------------------
    always @(*) begin
        rdata = 32'd0;

        case (addr)
            6'h10: rdata = mac_acc;
            6'h14: rdata = total_ops;
            6'h18: rdata = skipped_ops;
            default: rdata = 32'd0;
        endcase
    end

endmodule