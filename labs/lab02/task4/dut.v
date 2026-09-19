// Task 4: AND gate delay comparison

// 1. Dataflow modeling
module and_df (
    input a,
    input b,
    output y
);

    assign #5 y = a & b;

endmodule


// 2. Behavioral modeling: delay before assignment
module and_beh_before (
    input a,
    input b,
    output reg y
);

    always @(*) begin
        #5;
        y = a & b;
    end

endmodule


// 3. Behavioral modeling: intra-assignment delay
module and_beh_intra (
    input a,
    input b,
    output reg y
);

    always @(*) begin
        y = #5 (a & b);
    end

endmodule