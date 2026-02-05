// design.sv 
module vending ( 
    input  logic       clk, 
    input  logic       rst, 
    input  logic [4:0] coin, 
    output logic       dispense 
); 
 
    typedef enum logic [1:0] { 
        IDLE,     // 0 amount 
        HAS5,     // 5 collected 
        HAS10     // 10 collected 
    } state_t; 
 
    state_t state, next_state; 
 
    // State register 
    always_ff @(posedge clk or posedge rst) begin 
        if (rst) 
            state <= IDLE; 
        else 
            state <= next_state; 
    end 
 
    // Next-state and output logic 
    always_comb begin 
        dispense   = 1'b0; 
        next_state = state; 
 
        case (state) 
            IDLE: begin 
                if (coin == 5) 
                    next_state = HAS5; 
                else if (coin == 10) 
                    next_state = HAS10; 
            end 
 
            HAS5: begin 
                if (coin == 5) begin 
                    dispense   = 1'b1; 
                    next_state = IDLE; 
                end 
                else if (coin == 10) begin 
                    dispense   = 1'b1; 
                    next_state = IDLE; 
                end 
            end 
 
            HAS10: begin 
                dispense   = 1'b1; 
                next_state = IDLE; 
            end 
        endcase 
    end 
 
endmodule
