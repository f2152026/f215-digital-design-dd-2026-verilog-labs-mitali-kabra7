module tb;

    reg [3:0] t_a;
    reg [3:0] t_b;
    reg       t_op;

    wire [3:0] t_result;

    integer a, b, op;
    integer errors;
    reg [3:0] expected;

    alu dut (
        .a(t_a),
        .b(t_b),
        .op(t_op),
        .result(t_result)
    );

    initial begin
        errors = 0;

        // Test all 16 x 16 x 2 = 512 combinations
        for (op = 0; op < 2; op = op + 1) begin
            for (a = 0; a < 16; a = a + 1) begin
                for (b = 0; b < 16; b = b + 1) begin

                    t_a = a;
                    t_b = b;
                    t_op = op;

                    #1;

                    if (op == 0)
                        expected = a + b;
                    else
                        expected = a - b;

                    if (t_result !== expected) begin
                        $display("FAIL: op=%0d a=%0d b=%0d | expected=%0d actual=%0d",
                                 op, a, b, expected, t_result);
                        errors = errors + 1;
                    end

                end
            end
        end

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule