
`timescale 1ns/1ps

module tb_sa_mac_soc_top;

    parameter DATA_W = 8;
    parameter ACC_W  = 32;
    parameter N_OPS  = 1024;

    // Clock & reset
    reg clk;
    reg rst_n;

    // Control
    reg start_exec;
    wire exec_done;

    // Streaming inputs
    reg signed [DATA_W-1:0] a_in;
    reg signed [DATA_W-1:0] b_in;
    reg data_valid;

    // Outputs
    wire signed [ACC_W-1:0] acc_out;
    wire [31:0] total_ops_out;
    wire [31:0] skipped_ops_out;

    // Memory arrays
    reg signed [7:0] input_mem  [0:N_OPS-1];
    reg signed [7:0] weight_mem [0:N_OPS-1];

    integer i;
    integer golden_acc;

    // DUT
    sa_mac_soc_top #(
        .DATA_W(DATA_W),
        .ACC_W (ACC_W),
        .N_OPS (N_OPS)
    ) dut (
        .clk            (clk),
        .rst_n          (rst_n),
        .start_exec     (start_exec),
        .exec_done      (exec_done),
        .a_in           (a_in),
        .b_in           (b_in),
        .data_valid     (data_valid),
        .acc_out        (acc_out),
        .total_ops_out  (total_ops_out),
        .skipped_ops_out(skipped_ops_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset
    initial begin
        rst_n = 0;
        start_exec = 0;
        data_valid = 0;
        #100;
        rst_n = 1;
    end

    // Main test
    initial begin

        @(posedge rst_n);

        // Load data
        $readmemh("input_mem.txt", input_mem);
        $readmemh("weight_mem.txt", weight_mem);

        // Golden reference
        golden_acc = 0;
        for (i = 0; i < N_OPS; i = i + 1) begin
            golden_acc = golden_acc + (input_mem[i] * weight_mem[i]);
        end

        $display("======================================");
        $display("AI MAC Accelerator Simulation");
        $display("======================================");

        // Start execution
        start_exec = 1;
        @(posedge clk);
        start_exec = 0;

        // Feed inputs
        for (i = 0; i < N_OPS; i = i + 1) begin

            a_in = input_mem[i];
            b_in = weight_mem[i];

            data_valid = 1;
            @(posedge clk);   // write A
            @(posedge clk);   // write B
            data_valid = 0;
            @(posedge clk);   // gap cycle
        end

        // Wait for completion
        wait(exec_done);
        @(posedge clk);

        $display("--------------- RESULTS ----------------");
        $display("Hardware ACC Result : %0d", acc_out);
        $display("Golden   ACC Result : %0d", golden_acc);
        $display("Total Ops           : %0d", total_ops_out);
        $display("Skipped Ops         : %0d", skipped_ops_out);

        if (acc_out == golden_acc)
            $display("STATUS: PASS");
        else
            $display("STATUS: FAIL");

        $display("----------------------------------------");

        #100;
        $finish;
    end

endmodule