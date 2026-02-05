// design.sv 
module siso ( 
input  logic clk, 
input  logic si, 
output logic so 
); 
logic [3:0] q; 
// Serial output is MSB 
assign so = q[3]; 
always_ff @(posedge clk) begin 
q <= {q[2:0], si};   // shift left, load si into LSB 
end 
endmodule
