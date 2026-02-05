// testbench.sv 
module tb; 
 
    logic   clk; 
    logic   rst; 
    light_t color; 
 
    // DUT 
    traffic dut ( 
        .clk   (clk), 
        .rst   (rst), 
        .color (color) 
    ); 
 
    // Clock generation 
    always #5 clk = ~clk; 
 
    initial begin 
        // Waveform dump 
        $dumpfile("wave.vcd"); 
        $dumpvars(0, tb); 
        $dumpvars(0, dut); 
 
        // Init 
        clk = 0; 
        rst = 1; 
 
        #10 rst = 0;   // release reset 
#100;         
$finish; 
end 
endmodule 
 // run simulation
