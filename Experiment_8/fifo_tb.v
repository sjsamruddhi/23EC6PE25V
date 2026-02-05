// testbench.sv 
module tb; 
 
    logic clk = 0; 
    always #5 clk = ~clk; 
 
    // Interface instance 
    fifo_if vif (clk); 
 
    // DUT 
    fifo dut ( 
        .clk   (clk), 
        .wr    (vif.wr), 
        .rd    (vif.rd), 
        .din   (vif.din), 
        .full  (vif.full), 
        .empty (vif.empty) 
    ); 
 
    // Coverage: write when full 
    covergroup cg_fifo @(posedge clk); 
        cross_wr_full : cross vif.wr, vif.full; 
    endgroup 
 
    cg_fifo cg = new(); 
 
    initial begin 
        // Waveform 
        $dumpfile("wave.vcd"); 
        $dumpvars(0, tb); 
 
        // Init 
        vif.wr  = 0; 
        vif.rd  = 0; 
        vif.din = 0; 
 
        // Fill FIFO 
        vif.wr = 1; 
        repeat (18) @(posedge clk); 
 
        vif.wr = 0; 
        repeat (5) @(posedge clk); 
 
        $display("Coverage = %0.2f %%", cg.get_inst_coverage()); 
        $finish; 
    end 
 
endmodule
