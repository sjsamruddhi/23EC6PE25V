// tb.sv 
module tb; 
 
    logic clk = 0; 
    logic rst; 
    logic [3:0] count; 
 
    // DUT 
    counter dut ( 
        .clk   (clk), 
        .rst   (rst), 
        .count (count) 
    ); 
 
    // Clock generation 
    always #5 clk = ~clk; 
 
    // Coverage 
    covergroup cg @(posedge clk); 
        coverpoint count { 
            bins zero = {0}; 
            bins max  = {15}; 
            bins roll = (15 => 0);   // rollover transition 
        } 
    endgroup 
 
    cg cg_inst = new(); 
 
    initial begin 
        // Waveform dump 
        $dumpfile("wave.vcd"); 
        $dumpvars(0, tb); 
 
        // Reset 
        rst = 1; 
        #20; 
        rst = 0; 
 
        // Run for enough cycles to hit rollover 
        repeat (40) @(posedge clk); 
 
        $display("Rollover Hit? %0d", 
                 cg_inst.get_coverage()); 
 
        $finish; 
    end 
 
endmodule
