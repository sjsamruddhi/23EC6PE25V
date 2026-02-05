// design.sv 
module counter ( 
input  logic      
input  logic      
 clk, 
 rst, 
output logic [3:0] count 
); 
always_ff @(posedge clk or posedge rst) begin 
if (rst) 
count <= 4'd0; 
else 
count <= count + 1'b1; 
end 
endmodule
