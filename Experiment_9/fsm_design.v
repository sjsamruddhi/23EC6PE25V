`timescale 1ns/1ps 
 
module fsm_101 ( 
    input  logic clk, 
    input  logic rst, 
    input  logic in, 
    output logic out 
); 
 
    typedef enum logic [1:0] { 
        S0,   // idle 
        S1,   // saw 1 
        S2    // saw 10 
    } state_t; 
 
    state_t state, next; 
 
    // State register 
    always_ff @(posedge clk or posedge rst) begin 
        if (rst) 
            state <= S0; 
        else 
            state <= next; 
    end 
 
    // Next-state + output logic 
    always_comb begin 
        out  = 1'b0; 
        next = state; 
 
        case (state) 
            S0: begin 
                if (in) next = S1; 
            end 
 
            S1: begin 
                if (in) next = S1; 
                else    next = S2; 
            end 
 
            S2: begin 
                if (in) begin 
                    out  = 1'b1;   // 101 detected 
                    next = S1; 
                end else begin 
                    next = S0; 
                end 
            end 
        endcase 
    end 
 
endmodule
