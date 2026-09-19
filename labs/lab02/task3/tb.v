// tb.v
// Self-checking testbench for 2-bit comparator

module tb;

  reg [1:0] t_A;
  reg [1:0] t_B;

  wire t_GT;
  wire t_LT;
  wire t_EQ;

  integer a, b;
  integer errors;

  // Instantiate the design under test
  comp2 dut (
    .A(t_A),
    .B(t_B),
    .GT(t_GT),
    .LT(t_LT),
    .EQ(t_EQ)
  );

  initial begin
    errors = 0;

    // Test all combinations of 2-bit numbers (0 to 3)
    for (a = 0; a < 4; a = a + 1) begin
      for (b = 0; b < 4; b = b + 1) begin
        t_A = a[1:0];
        t_B = b[1:0];
        #1;

        if ((t_GT !== (a > b)) ||
            (t_LT !== (a < b)) ||
            (t_EQ !== (a == b))) begin
          $display("FAIL: A=%0d B=%0d | GT=%b LT=%b EQ=%b",
                   a, b, t_GT, t_LT, t_EQ);
          errors = errors + 1;
        end else begin
          $display("PASS: A=%0d B=%0d", a, b);
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