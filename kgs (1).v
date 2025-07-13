module gp_calc (
    input wire a,
    input wire b,
    input wire cin,
    output wire g,
    output wire p
);
    assign g = a & b;
    assign p = a ^ b;
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
   
    // Level 0: Initial G and P computation
    wire [3:0] g0, p0;
   
    gp_calc gp0 (.a(a[0]), .b(b[0]), .cin(cin), .g(g0[0]), .p(p0[0]));
    gp_calc gp1 (.a(a[1]), .b(b[1]), .cin(1'b0), .g(g0[1]), .p(p0[1]));
    gp_calc gp2 (.a(a[2]), .b(b[2]), .cin(1'b0), .g(g0[2]), .p(p0[2]));
    gp_calc gp3 (.a(a[3]), .b(b[3]), .cin(1'b0), .g(g0[3]), .p(p0[3]));
   
    // Level 1: First prefix computation
    wire [3:0] g1, p1;
   
    assign g1[0] = g0[0];
    assign p1[0] = p0[0];
   
    prefix_op pre1_1 (.gi(g0[1]), .pi(p0[1]), .gj(g0[0]), .pj(p0[0]), .go(g1[1]), .po(p1[1]));
   
    assign g1[2] = g0[2];
    assign p1[2] = p0[2];
   
    prefix_op pre1_3 (.gi(g0[3]), .pi(p0[3]), .gj(g0[2]), .pj(p0[2]), .go(g1[3]), .po(p1[3]));
   
    // Level 2: Second prefix computation
    wire [3:0] g2, p2;
   
    assign g2[0] = g1[0];
    assign p2[0] = p1[0];
    assign g2[1] = g1[1];
    assign p2[1] = p1[1];
   
    prefix_op pre2_2 (.gi(g1[2]), .pi(p1[2]), .gj(g1[1]), .pj(p1[1]), .go(g2[2]), .po(p2[2]));
    prefix_op pre2_3 (.gi(g1[3]), .pi(p1[3]), .gj(g1[1]), .pj(p1[1]), .go(g2[3]), .po(p2[3]));
   
    // Carry computation
    wire c0, c1, c2, c3;
    assign c0 = cin;
    assign c1 = g2[0] | (p2[0] & c0);
    assign c2 = g2[1] | (p2[1] & c0);
    assign c3 = g2[2] | (p2[2] & c0);
    assign cout = g2[3] | (p2[3] & c0);
   
    // Sum computation
    assign sum[0] = a[0] ^ b[0] ^ c0;
    assign sum[1] = a[1] ^ b[1] ^ c1;
    assign sum[2] = a[2] ^ b[2] ^ c2;
    assign sum[3] = a[3] ^ b[3] ^ c3;
   
endmodule







