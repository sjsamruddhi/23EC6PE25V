// design.sv 
class Packet; 
rand bit [7:0] data; 
virtual function void print(); 
$display("NORMAL PACKET: %h", data); 
endfunction 
endclass 
class BadPacket extends Packet; 
virtual function void print(); 
$display("ERROR PACKET: %h", data); 
endfunction 
endclass
