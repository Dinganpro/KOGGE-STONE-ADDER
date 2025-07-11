// File: kogge_stone_complete.v

// D Flip-Flop module
module dff (
    input wire clk,
    input wire rst,
    input wire d,
    output reg q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule

// Prefix computation module for Kogge-Stone
module prefix_op (
    input wire gi,
    input wire pi,
    input wire gj,
    input wire pj,
    output wire go,
    output wire po
);
    assign go = gi | (pi & gj);
    assign po = pi & pj;
endmodule

// 4-bit Kogge-Stone Adder Core
module kogge_stone_4bit (
    input wire [3:0] a,
    input wire [3:0] b,
    input wire cin,
    output wire [3:0] sum,
    output wire cout
);
    wire [3:0] g0, p0;

    assign g0 = a & b;
    assign p0 = a ^ b;

    wire [3:0] g1, p1;
    assign g1[0] = g0[0] | (p0[0] & cin);
    assign p1[0] = p0[0];

    prefix_op pre1_1 (.gi(g0[1]), .pi(p0[1]), .gj(g1[0]), .pj(p0[0]), .go(g1[1]), .po(p1[1]));
    assign g1[2] = g0[2]; assign p1[2] = p0[2];
    prefix_op pre1_3 (.gi(g0[3]), .pi(p0[3]), .gj(g0[2]), .pj(p0[2]), .go(g1[3]), .po(p1[3]));

    wire [3:0] g2, p2;
    assign g2[0] = g1[0]; assign p2[0] = p1[0];
    assign g2[1] = g1[1]; assign p2[1] = p1[1];
    prefix_op pre2_2 (.gi(g1[2]), .pi(p1[2]), .gj(g1[1]), .pj(p1[1]), .go(g2[2]), .po(p2[2]));
    prefix_op pre2_3 (.gi(g1[3]), .pi(p1[3]), .gj(g1[1]), .pj(p1[1]), .go(g2[3]), .po(p2[3]));

    wire c1 = g2[0];
    wire c2 = g2[1];
    wire c3 = g2[2];
    assign cout = g2[3];

    assign sum[0] = a[0] ^ b[0] ^ cin;
    assign sum[1] = a[1] ^ b[1] ^ c1;
    assign sum[2] = a[2] ^ b[2] ^ c2;
    assign sum[3] = a[3] ^ b[3] ^ c3;
endmodule
