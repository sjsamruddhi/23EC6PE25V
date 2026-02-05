`timescale 1ns/1ps 
 
module tb; 
 
    logic clk = 0; 
    logic rst; 
    logic in; 
    logic out; 
 
    // DUT 
    fsm_101 dut ( 
        .clk (clk), 
        .rst (rst), 
        .in  (in), 
        .out (out) 
    ); 
 
    // Clock 
    always #5 clk = ~clk; 
 
    // WHITE-BOX COVERAGE (internal state) 
    covergroup cg @(posedge clk); 
        cp_state : coverpoint dut.state; 
    endgroup 
 
    cg c = new(); 
 
    // Dump waves 
    initial begin 
        $dumpfile("wave.vcd"); 
        $dumpvars(0, tb); 
        $dumpvars(0, dut); 
    end 
 
    initial begin 
        // Init 
        rst = 1; 
        in  = 0; 
        @(posedge clk); 
        rst = 0; 
 
        // Apply sequence: 1 0 1 
        @(posedge clk) in = 1; 
        @(posedge clk) in = 0; 
        @(posedge clk) in = 1; 
        @(posedge clk) in = 0; 
 
        $display("Coverage = %0.2f %%", c.get_inst_coverage()); 
 
        #10; 
        $finish; 
    end 
 
endmodule
