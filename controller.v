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