// design.sv 
module fifo ( 
    input  logic       clk, 
    input  logic       wr, 
    input  logic       rd, 
    input  logic [7:0] din, 
    output logic       full, 
    output logic       empty 
); 
 
    logic [4:0] cnt;   // can count 0–16 
 
    assign full  = (cnt == 5'd16); 
    assign empty = (cnt == 5'd0); 
 
    always_ff @(posedge clk) begin 
        case ({wr, rd}) 
            2'b10: if (!full)  cnt <= cnt + 1; // write 
            2'b01: if (!empty) cnt <= cnt - 1; // read 
            default: cnt <= cnt;               // no change 
        endcase 
    end 
 
endmodule
