module tb; 
 
    logic [7:0] a, b, y; 
    opcode_e   op; 
 
    // DUT instantiation 
    alu dut ( 
        .a(a), 
        .b(b), 
        .op(op), 
        .y(y) 
    ); 
 
    // Coverage 
    covergroup cg; 
        cp_op : coverpoint op; 
    endgroup 
 
    cg c = new(); 
 
    initial begin 
        // EPWave dump 
        $dumpfile("wave.vcd"); 
        $dumpvars(0, tb); 
 
        repeat (50) begin 
            a  = $urandom(); 
            b  = $urandom(); 
op = opcode_e'($urandom_range(0,3)); 
#5; 
c.sample(); 
end 
$display("Coverage = %0.2f %%", c.get_inst_coverage()); 
$finish; 
end 
endmodule
