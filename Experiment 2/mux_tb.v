class Transaction; 
    rand bit [7:0] a, b; 
    rand bit       sel; 
endclass 
 
 
module tb; 
    logic [7:0] a, b, y; 
    logic       sel; 
 
    // DUT 
    mux2to1 dut ( 
        .a(a), 
        .b(b), 
        .sel(sel), 
        .y(y) 
    ); 
 
    // Coverage 
    covergroup cgmux; 
        cp_sel : coverpoint sel;   // Sel = 0 and 1 
    endgroup 
 
    cgmux cg = new(); 
    Transaction tr = new(); 
 
    //   Waveform dump (REQUIRED for EPWave) 
    initial begin 
        $dumpfile("wave.vcd"); 
        $dumpvars(0, tb); 
    end 
 
    // Stimulus 
    initial begin 
        repeat (20) begin 
            tr.randomize(); 
            a   = tr.a; 
            b   = tr.b; 
            sel = tr.sel; 
            #5; 
            cg.sample(); 
 
            // Self-check 
            if (y !== (sel ? b : a)) 
                $error("Mismatch! a=%0h b=%0h sel=%0b y=%0h", 
                       a, b, sel, y); 
        end 
 
        $display("Coverage = %0.2f %%", cg.get_inst_coverage()); 
        #10; 
        $finish; 
    end 
endmodule
