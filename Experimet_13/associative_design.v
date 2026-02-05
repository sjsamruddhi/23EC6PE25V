`timescale 1ns/1ps 
 
module assoc_design ( 
    input  logic clk, 
    input  logic we, 
    input  int   addr, 
    input  int   din, 
    output int   dout 
); 
 
    // Associative array: address → data 
    int mem[int]; 
 
    always_ff @(posedge clk) begin 
        if (we) begin 
            mem[addr] <= din; 
        end 
        else begin 
            if (mem.exists(addr)) 
                dout <= mem[addr]; 
            else 
                dout <= 0; 
        end 
    end 
 
endmodule
