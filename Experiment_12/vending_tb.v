// testbench.sv 
module tb; 
 
    logic clk; 
    logic rst; 
    logic [4:0] coin; 
    logic dispense; 
 
    // DUT 
    vending dut ( 
        .clk      (clk), 
        .rst      (rst), 
        .coin     (coin), 
        .dispense (dispense) 
    ); 
 
    // Clock 
    initial clk = 0; 
    always #5 clk = ~clk; 
 
    // White-box coverage on internal FSM state 
    covergroup cg @(posedge clk); 
        cp_state : coverpoint dut.state; 
    endgroup 
 
    cg vend_cg = new(); 
 
    // Waveform dump 
    initial begin 
        $dumpfile("wave.vcd"); 
        $dumpvars(0, tb); 
        $dumpvars(0, dut); 
    end 
 
    // Stimulus 
    initial begin 
        rst  = 1; 
        coin = 0; 
        #10 rst = 0; 
 
        repeat (20) begin 
            // Randomly generate 0, 5, or 10 
            case ($urandom_range(0,2)) 
                0: coin = 0; 
                1: coin = 5; 
                2: coin = 10; 
            endcase 
 
            @(posedge clk); 
            vend_cg.sample(); 
        end 
 
        $display("FSM State Coverage = %0.2f %%", vend_cg.get_inst_coverage()); 
        #20; 
        $finish; 
    end 
endmodule
