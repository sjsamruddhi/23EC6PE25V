// testbench.sv 
`timescale 1ns/1ps 
 
module tb; 
 
    logic [7:0] data_sig; 
 
    Packet    p; 
    BadPacket bad; 
 
    initial begin 
        // Create derived object 
        bad = new(); 
 
        // Polymorphism: base handle points to derived object 
        p = bad; 
 
        // Dump waveform 
        $dumpfile("dump.vcd"); 
        $dumpvars(0, tb); 
 
        repeat (5) begin 
            p.randomize(); 
            data_sig = p.data;   // Move class data to signal 
            p.print();           // Calls BadPacket::print() 
            #5; 
        end 
 
$finish; 
end 
endmodule
