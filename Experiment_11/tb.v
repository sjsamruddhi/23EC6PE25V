// testbench.sv 
module tb; 
 
    logic clk; 
    logic rst; 
    logic [3:0] req; 
    logic [3:0] gnt; 
 
    // DUT 
    arbiter dut ( 
        .clk (clk), 
        .rst (rst), 
        .req (req), 
        .gnt (gnt) 
    ); 
 
    // Clock generation 
    initial clk = 0; 
    always #5 clk = ~clk; 
 
    // Waveform dump 
    initial begin 
        $dumpfile("wave.vcd"); 
        $dumpvars(0, tb); 
        $dumpvars(0, dut); 
    end 
 
    // Stimulus 
    initial begin 
        rst = 1; 
        req = 4'b0000; 
        #10 rst = 0; 
 
        #10 req = 4'b0001;  // grant 0 
        #10 req = 4'b0011;  // still grant 0 
        #10 req = 4'b0000;  // no grant 
        #10 req = 4'b0100;  // grant 2 
 
        #20; 
        $finish; 
    end 
 
    // Assertion: at most one grant bit high 
    property onehot_gnt; 
        @(posedge clk) $onehot0(gnt); 
    endproperty 
 
    assert_onehot_gnt: assert property (onehot_gnt) 
        else $error("Protocol violation: Multiple grants asserted!"); 
 
endmodule
