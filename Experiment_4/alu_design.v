// design.sv 
typedef enum logic [1:0] { 
    ADD = 2'b00, 
    SUB = 2'b01, 
    AND = 2'b10, 
    OR  = 2'b11 
} opcode_e; 
 
module alu ( 
    input  logic [7:0] a, 
    input  logic [7:0] b, 
    input  opcode_e    op, 
    output logic [7:0] y 
); 
 
    always_comb begin 
        case (op) 
            ADD: y = a + b; 
            SUB: y = a - b; 
            AND: y = a & b; 
            OR : y = a | b; 
            default: y = 8'h00; 
        endcase 
    end 
 
endmodule
