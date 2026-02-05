module tb;  
    logic a, b, y; 
 
   // DUT 
    and_gate dut ( 
        .a(a), 
        .b(b), 
        .y(y) 
    ); 
 
    // Coverage group 
    covergroup cg_and; 
        cp_a: coverpoint a; 
        cp_b: coverpoint b; 
        cross_ab: cross cp_a, cp_b; 
    endgroup 
 
    cg_and cg = new(); 
 
    // Waveform dump (IMPORTANT for EPWave) 
    initial begin 
        $dumpfile("wave.vcd");   // EPWave reads this 
        $dumpvars(0, tb); 
    end 
 
    // Stimulus 
    initial begin 
        repeat (20) begin 
            a = $urandom_range(0,1); 
            b = $urandom_range(0,1); 
            #5; 
            cg.sample(); 
        end 
 
        $display("Final Coverage = %0.2f %%", cg.get_inst_coverage()); 
        #10; 
        $finish; 
    end 
endmodule
