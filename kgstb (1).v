module tb_kogge_stone_adder;
   
    reg clk;
    reg rst;
    reg [3:0] a_in;
    reg [3:0] b_in;
    reg cin_in;
    wire [3:0] sum_out;
    wire cout_out;
   
    // Instantiate the top module
    kogge_stone_top uut (
        .clk(clk),
        .rst(rst),
        .a_in(a_in),
        .b_in(b_in),
        .cin_in(cin_in),
        .sum_out(sum_out),
        .cout_out(cout_out)
    );
   
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period
    end
   
    // Test stimulus
    initial begin
        $dumpfile("kogge_stone_adder.vcd");
        $dumpvars(0, tb_kogge_stone_adder);
       
        // Initialize
        rst = 1;
        a_in = 4'b0000;
        b_in = 4'b0000;
        cin_in = 1'b0;
       
        // Reset
        #10;
        rst = 0;
        #10;
       
        // Test cases
        $display("Starting Kogge-Stone Adder Tests");
        $display("Time\tA\tB\tCin\tSum\tCout\tExpected");

        // Existing test cases
        a_in = 4'b0000; b_in = 4'b0000; cin_in = 1'b0; #20;
        a_in = 4'b0001; b_in = 4'b0001; cin_in = 1'b0; #20;
        a_in = 4'b0101; b_in = 4'b0011; cin_in = 1'b1; #20;
        a_in = 4'b0111; b_in = 4'b1000; cin_in = 1'b0; #20;
        a_in = 4'b1111; b_in = 4'b1111; cin_in = 1'b1; #20;
        a_in = 4'b1001; b_in = 4'b0110; cin_in = 1'b0; #20;
        a_in = 4'b1100; b_in = 4'b0100; cin_in = 1'b1; #20;
        a_in = 4'b0000; b_in = 4'b1111; cin_in = 1'b1; #20;

        // Additional test cases
        a_in = 4'b0011; b_in = 4'b0111; cin_in = 1'b1; #20;
        a_in = 4'b0010; b_in = 4'b0101; cin_in = 1'b0; #20;
        a_in = 4'b1110; b_in = 4'b0001; cin_in = 1'b1; #20;
        a_in = 4'b0110; b_in = 4'b1001; cin_in = 1'b1; #20;
        a_in = 4'b1101; b_in = 4'b0010; cin_in = 1'b0; #20;
        a_in = 4'b1011; b_in = 4'b0100; cin_in = 1'b1; #20;
        a_in = 4'b1000; b_in = 4'b0111; cin_in = 1'b1; #20;
        a_in = 4'b0101; b_in = 4'b1010; cin_in = 1'b0; #20;
        a_in = 4'b0010; b_in = 4'b1101; cin_in = 1'b1; #20;
        a_in = 4'b0111; b_in = 4'b0101; cin_in = 1'b1; #20;
        a_in = 4'b0001; b_in = 4'b1110; cin_in = 1'b0; #20;

        // Newly added test cases
        a_in = 4'b0100; b_in = 4'b1011; cin_in = 1'b0; #20;
        a_in = 4'b0111; b_in = 4'b0110; cin_in = 1'b1; #20;
        a_in = 4'b1000; b_in = 4'b1001; cin_in = 1'b0; #20;
        a_in = 4'b1010; b_in = 4'b0010; cin_in = 1'b1; #20;
        a_in = 4'b1110; b_in = 4'b0011; cin_in = 1'b0; #20;
        a_in = 4'b0101; b_in = 4'b1100; cin_in = 1'b1; #20;
        a_in = 4'b1101; b_in = 4'b0111; cin_in = 1'b0; #20;
        a_in = 4'b0011; b_in = 4'b1100; cin_in = 1'b1; #20;
        a_in = 4'b1001; b_in = 4'b0101; cin_in = 1'b1; #20;
        a_in = 4'b0010; b_in = 4'b1110; cin_in = 1'b0; #20;

        $display("Test completed");
        #20;
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("At time %t: A=%b B=%b Cin=%b -> Sum=%b Cout=%b",
                 $time, a_in, b_in, cin_in, sum_out, cout_out);
    end

endmodule
