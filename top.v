
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


module sa_mac_controller #(
    parameter DATA_W = 8,
    parameter N_OPS  = 1024
)(
    input  clk,
    input  rst_n,

    input  start_exec,

    input  signed [DATA_W-1:0] a_in,
    input  signed [DATA_W-1:0] b_in,
    input  data_valid,

    output reg        wr_en,
    output reg [5:0]  addr,
    output reg [31:0] wdata,

    output reg exec_done
);

    // State encoding
    localparam IDLE      = 2'b00;
    localparam RUN       = 2'b01;
    localparam WAIT_LAST = 2'b10;
    localparam DONE      = 2'b11;

    reg [1:0] state;

    reg phase;
    reg [9:0] op_count;   // log2(1024) = 10 bits

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state      <= IDLE;
            phase      <= 1'b0;
            op_count   <= 10'd0;
            wr_en      <= 1'b0;
            addr       <= 6'd0;
            wdata      <= 32'd0;
            exec_done  <= 1'b0;
        end
        else begin
            wr_en     <= 1'b0;
            exec_done <= 1'b0;

            case (state)

                IDLE: begin
                    if (start_exec) begin
                        state    <= RUN;
                        phase    <= 1'b0;
                        op_count <= 10'd0;
                    end
                end

                RUN: begin
                    if (data_valid) begin

                        if (phase == 1'b0) begin
                            // Write A
                            wr_en <= 1'b1;
                            addr  <= 6'h04;
                            wdata <= a_in;
                            phase <= 1'b1;
                        end
                        else begin
                            // Write B (triggers MAC)
                            wr_en <= 1'b1;
                            addr  <= 6'h08;
                            wdata <= b_in;
                            phase <= 1'b0;

                            op_count <= op_count + 1'b1;

                            if (op_count + 1'b1 == N_OPS) begin
                                state <= WAIT_LAST;
                            end
                        end
                    end
                end

                WAIT_LAST: begin
                    state <= DONE;
                end

                DONE: begin
                    exec_done <= 1'b1;
                    state     <= IDLE;
                end

            endcase
        end
    end

endmodule



module sa_mac_soc_top #(
    parameter DATA_W = 8,
    parameter ACC_W  = 32,
    parameter N_OPS  = 1024
)(
    // Clock & reset
    input clk,
    input rst_n,

    // Control
    input start_exec,
    output exec_done,

    // Streaming data inputs
    input  signed [DATA_W-1:0] a_in,
    input  signed [DATA_W-1:0] b_in,
    input  data_valid,

    // Outputs
    output signed [ACC_W-1:0] acc_out,
    output [31:0] total_ops_out,
    output [31:0] skipped_ops_out
);

    // -------------------------------------------------
    // Internal signals
    // -------------------------------------------------
    wire        wr_en;
    wire [5:0]  addr;
    wire [31:0] wdata;

    wire                     mac_valid;
    wire                     zero_skip_enable;
    wire signed [DATA_W-1:0] mac_a;
    wire signed [DATA_W-1:0] mac_b;

    wire signed [ACC_W-1:0]  mac_acc;
    wire                     mac_skipped;

    wire [31:0] total_ops;
    wire [31:0] skipped_ops;

    // -------------------------------------------------
    // Controller
    // -------------------------------------------------
    sa_mac_controller #(
        .DATA_W(DATA_W),
        .N_OPS (N_OPS)
    ) u_controller (
        .clk        (clk),
        .rst_n      (rst_n),
        .start_exec (start_exec),
        .a_in       (a_in),
        .b_in       (b_in),
        .data_valid (data_valid),
        .wr_en      (wr_en),
        .addr       (addr),
        .wdata      (wdata),
        .exec_done  (exec_done)
    );

    // -------------------------------------------------
    // Register block
    // -------------------------------------------------
    sa_mac_regs #(
        .DATA_W(DATA_W),
        .ACC_W (ACC_W)
    ) u_regs (
        .clk              (clk),
        .rst_n            (rst_n),
        .wr_en            (wr_en),
        .rd_en            (1'b0),
        .addr             (addr),
        .wdata            (wdata),
        .rdata            (),

        .mac_valid        (mac_valid),
        .zero_skip_enable (zero_skip_enable),
        .mac_a            (mac_a),
        .mac_b            (mac_b),

        .mac_acc          (mac_acc),
        .mac_skipped      (mac_skipped),

        .total_ops        (total_ops),
        .skipped_ops      (skipped_ops)
    );

    // -------------------------------------------------
    // MAC Core
    // -------------------------------------------------
    sa_mac_core #(
        .DATA_W(DATA_W),
        .ACC_W (ACC_W)
    ) u_mac (
        .clk              (clk),
        .rst_n            (rst_n),
        .valid            (mac_valid),
        .zero_skip_enable (zero_skip_enable),
        .a                (mac_a),
        .b                (mac_b),
        .acc              (mac_acc),
        .skipped          (mac_skipped)
    );

    // -------------------------------------------------
    // Outputs
    // -------------------------------------------------
    assign acc_out         = mac_acc;
    assign total_ops_out   = total_ops;
    assign skipped_ops_out = skipped_ops;

endmodule
