`timescale 1ns / 1ps

module sender_algo(
input send,
input bit_msg,
input base, //Alice's base
input clk,
output reg [1:0]public_msg
);

always @(posedge clk)
    begin
    if(send == 1'b1)
        begin
            public_msg[1] <= bit_msg;
            public_msg[0] <= base;
        end
    end
endmodule


//test bench for above simulation
module sender_tb;
reg send;
reg bit_msg;
reg base_A;
reg clk;
wire [1:0]public_msg;

sender_algo s1(
send, bit_msg, base_A, clk, public_msg);

initial
begin
clk = 1'b0;
send = 1'b1;
bit_msg = 1'b0;
base_A = 1'b0;
#8
bit_msg = 1'b0;
base_A = 1'b1;
#16
bit_msg = 1'b1;
base_A = 1'b0;
#24
bit_msg = 1'b1;
base_A = 1'b1;
#32
bit_msg = 1'b0;
base_A = 1'b0;
end

always #2 clk = clk + 1'b1;

endmodule
