// tb.sv 
 
// Packet class 
class packet; 
    rand bit d; 
    rand bit rst; 
 
    // Reset asserted 10% of the time 
    constraint c1 { 
        rst dist {0 := 90, 1 := 10}; 
    } 
endclass 
 
 
module tb; 
 
    logic clk = 0; 
    logic rst; 
    logic d; 
    logic q; 
 
    // DUT 
    dff dut ( 
        .clk(clk), 
        .rst(rst), 
        .d(d), 
        .q(q) 
    ); 
 
    // Clock generation 
    always #5 clk = ~clk; 
 
    // Coverage 
    covergroup cg @(posedge clk); 
        cross_rst_d : cross rst, d; 
    endgroup 
 
    cg c = new(); 
    packet p = new(); 
 
    initial begin 
        // Waveform for EPWave / GTKWave 
        $dumpfile("wave.vcd"); 
        $dumpvars(0, tb); 
 
        repeat (100) begin 
            p.randomize(); 
            rst <= p.rst; 
            d   <= p.d; 
            @(posedge clk); 
            c.sample(); 
        end 
 
        $display("Coverage = %0.2f %%", c.get_inst_coverage()); 
        $finish; 
    end
