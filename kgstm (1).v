module kogge_stone_top (
    input wire clk,
    input wire rst,
    input wire [3:0] a_in,
    input wire [3:0] b_in,
    input wire cin_in,
    output wire [3:0] sum_out,
    output wire cout_out
);
   
    // Input registers
    wire [3:0] a_reg, b_reg;
    wire cin_reg;
   
    // Output registers
    reg [3:0] sum_reg;
    reg cout_reg;
   
    // Input D Flip-Flops
    dff dff_a0 (.clk(clk), .rst(rst), .d(a_in[0]), .q(a_reg[0]));
    dff dff_a1 (.clk(clk), .rst(rst), .d(a_in[1]), .q(a_reg[1]));
    dff dff_a2 (.clk(clk), .rst(rst), .d(a_in[2]), .q(a_reg[2]));
    dff dff_a3 (.clk(clk), .rst(rst), .d(a_in[3]), .q(a_reg[3]));
   
    dff dff_b0 (.clk(clk), .rst(rst), .d(b_in[0]), .q(b_reg[0]));
    dff dff_b1 (.clk(clk), .rst(rst), .d(b_in[1]), .q(b_reg[1]));
    dff dff_b2 (.clk(clk), .rst(rst), .d(b_in[2]), .q(b_reg[2]));
    dff dff_b3 (.clk(clk), .rst(rst), .d(b_in[3]), .q(b_reg[3]));
   
    dff dff_cin (.clk(clk), .rst(rst), .d(cin_in), .q(cin_reg));
   
    // Adder core
    wire [3:0] sum_wire;
    wire cout_wire;
   
    kogge_stone_4bit adder_core (
        .a(a_reg),
        .b(b_reg),
        .cin(cin_reg),
        .sum(sum_wire),
        .cout(cout_wire)
    );
   
    // Output D Flip-Flops
    dff dff_sum0 (.clk(clk), .rst(rst), .d(sum_wire[0]), .q(sum_out[0]));
    dff dff_sum1 (.clk(clk), .rst(rst), .d(sum_wire[1]), .q(sum_out[1]));
    dff dff_sum2 (.clk(clk), .rst(rst), .d(sum_wire[2]), .q(sum_out[2]));
    dff dff_sum3 (.clk(clk), .rst(rst), .d(sum_wire[3]), .q(sum_out[3]));
   
    dff dff_cout (.clk(clk), .rst(rst), .d(cout_wire), .q(cout_out));
   
endmodule
