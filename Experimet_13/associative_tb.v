`timescale 1ns/1ps 
 
module tb; 
 
    bit  clk = 0; 
    bit  we; 
    int  addr; 
    int  din; 
    int  dout; 
 
    // DUT 
    assoc_design dut ( 
        .clk  (clk), 
        .we   (we), 
        .addr (addr), 
        .din  (din), 
        .dout (dout) 
    ); 
 
    // Clock generation 
    always #5 clk = ~clk; 
 
    // Dump waves 
    initial begin 
        $dumpfile("wave.vcd"); 
        $dumpvars(0, tb); 
        $dumpvars(0, dut); 
    end 
 
    // Stimulus 
    initial begin 
        we   = 0; 
        addr = 0; 
        din  = 0; 
 
        // Write operations 
        @(posedge clk) begin we = 1; addr = 10; din = 100; end 
        @(posedge clk) begin we = 1; addr = 25; din = 200; end 
        @(posedge clk) begin we = 1; addr = 50; din = 300; end 
 
        // Read operations 
        @(posedge clk) begin we = 0; addr = 10; end 
        @(posedge clk) begin addr = 25; end 
        @(posedge clk) begin addr = 50; end 
        @(posedge clk) begin addr = 99; end  // non-existing key 
 
        #10; 
        $finish; 
    end 
 
endmodule
