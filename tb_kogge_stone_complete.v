// File: tb_kogge_stone_complete.v

`timescale 1ns / 1ps

module tb_kogge_stone_complete;
    reg clk, rst;
    reg [3:0] a_in, b_in, a_core, b_core;
    reg cin_in, cin_core;
    wire [3:0] sum_out, sum_core;
    wire cout_out, cout_core;

    kogge_stone_top uut_top (
        .clk(clk),
        .rst(rst),
        .a_in(a_in),
        .b_in(b_in),
        .cin_in(cin_in),
        .sum_out(sum_out),
        .cout_out(cout_out)
    );

    kogge_stone_4bit uut_core (
        .a(a_core),
        .b(b_core),
        .cin(cin_core),
        .sum(sum_core),
        .cout(cout_core)
    );

    initial begin clk = 0; forever #5 clk = ~clk; end

    task test_combination;
        input [3:0] a_val, b_val;
        input cin_val;
        input [4:0] expected;
        input [127:0] test_name;
        begin
            a_core = a_val; b_core = b_val; cin_core = cin_val;
            #1;
            if ({cout_core, sum_core} !== expected)
                $display("ERROR %s: A=%b B=%b Cin=%b Expected=%b Got=%b", test_name, a_val, b_val, cin_val, expected, {cout_core, sum_core});
            else
                $display("PASS %s: A=%b B=%b Cin=%b Result=%b", test_name, a_val, b_val, cin_val, {cout_core, sum_core});
            a_in = a_val; b_in = b_val; cin_in = cin_val;
            #20;
        end
    endtask

    initial begin
        $dumpfile("kogge_stone_complete.vcd");
        $dumpvars(0, tb_kogge_stone_complete);

        rst = 1; a_in = 0; b_in = 0; cin_in = 0;
        a_core = 0; b_core = 0; cin_core = 0;
        #10; rst = 0; #10;

        $display("=== Basic Tests ===");
        test_combination(4'b0000, 4'b0000, 1'b0, 5'b00000, "Zero + Zero");
        test_combination(4'b0000, 4'b0000, 1'b1, 5'b00001, "Zero + Carry");
        test_combination(4'b1111, 4'b1111, 1'b1, 5'b11111, "Max + Max + 1");

        $display("=== Exhaustive Tests ===");
        for (integer a = 0; a < 16; a = a + 1)
            for (integer b = 0; b < 16; b = b + 1)
                for (integer c = 0; c < 2; c = c + 1) begin
                    a_core = a[3:0]; b_core = b[3:0]; cin_core = c[0]; #1;
                    if ({cout_core, sum_core} !== (a + b + c))
                        $display("EXHAUSTIVE ERROR: A=%d B=%d C=%d Expected=%d Got=%d", a, b, c, a + b + c, {cout_core, sum_core});
                end

        $display("=== Test Completed ===");
        #50 $finish;
    end
endmodule
