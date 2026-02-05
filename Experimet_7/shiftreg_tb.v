// testbench.sv 
module tb; 
 
    logic clk = 0; 
    logic si; 
    logic so; 
 
    // Reference model 
    logic [3:0] qref; 
 
    // DUT 
    siso dut ( 
        .clk(clk), 
        .si (si), 
        .so (so) 
    ); 
 
    // Clock generation 
    always #5 clk = ~clk; 
 
    initial begin 
        // Waveform 
        $dumpfile("wave.vcd"); 
        $dumpvars(0, tb); 
 
        qref = 4'b0000; 
 
        repeat (20) begin 
            si = $urandom() % 2; 
            qref = {qref[2:0], si}; 
 
            @(posedge clk); 
            #1; // allow DUT to update 
 
            $display("SI=%b SO=%b Expected=%b", 
                     si, so, qref[3]); 
 
            // Optional self-check 
            if (so !== qref[3]) 
                $error("Mismatch detected!"); 
        end 
 
        $finish; 
    end 
 
endmodule
