// design.sv 
typedef enum logic [1:0] { 
    RED, 
    GREEN, 
    YELLOW 
} light_t; 
 
module traffic ( 
    input  logic  clk, 
    input  logic  rst, 
    output light_t color 
); 
 
    always_ff @(posedge clk or posedge rst) begin 
        if (rst) 
            color <= RED; 
        else begin 
            case (color) 
                RED:    color <= GREEN; 
                GREEN:  color <= YELLOW; 
                YELLOW: color <= RED; 
                default:color <= RED; 
            endcase 
        end 
    end 
 
endmodule
