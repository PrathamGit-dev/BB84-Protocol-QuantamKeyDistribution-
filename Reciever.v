`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module reciever_algo(
//input recieve,
input [1:0]public_msg,
input b_dash, //BOB'S base
input clk,
output reg base0,
output reg base1,
output clk_output,
output reg r0,
output reg r1,
output reg ignore
    );
    
clock_divide clk_div(clk,clk_output
    ); 
//reducing the frequency of clock for visible output on FPGA
//comment this when using simulation on computer

always @(posedge clk_output)
begin
    if(b_dash == 1'b0)
        begin
            base0 <= 1'b1;
            base1 <= 1'b0;
        end
    if(b_dash == 1'b1)
        begin
            base1 = 1'b1;
            base0 <= 1'b0;
        end
    if(public_msg == 2'b00)
        begin
            if(b_dash == 1'b0)
                begin
                    r0 <= 1'b1;
                    r1 <= 1'b0;
                    ignore <= 1'b0;
                end
            else
                begin
                    r0 <= 1'b0;
                    r1 <= 1'b0;
                    ignore <= 1'b1;
                end
        end
    else if(public_msg == 2'b01)
        begin
            if(b_dash == 1'b0)
                begin
                    r0 <= 1'b0;
                    r1 <= 1'b0;
                    ignore <= 1'b1;
                end
            else
                begin
                    r0 <= 1'b1;
                    r1 <= 1'b0;
                    ignore <= 1'b0;
                end
        end
    else if(public_msg == 2'b10)
        begin
            if(b_dash == 1'b0)
                begin
                    r0 <= 1'b0;
                    r1 <= 1'b1;
                    ignore <= 1'b0;
                end
            else
                begin
                    r0 <= 1'b0;
                    r1 <= 1'b0;
                    ignore <= 1'b1; 
                end
        end
    else if(public_msg == 2'b11)
        begin
            if(b_dash == 1'b0)
                begin
                    r0 <= 1'b0;
                    r1 <= 1'b0;
                    ignore <= 1'b1;
                end
            else
                begin
                    r0 <= 1'b0;
                    r1 <= 1'b1;
                    ignore <= 1'b0;
                end
        end
    end
endmodule


//test bench for above simulation

module tb_reciever;
reg recieve;
reg [1:0]public_msg;
reg b_dash;
reg clk;
wire base0;
wire base1;
wire r0;
wire r1;
wire ignore;

reciever_algo r1_algo(public_msg, b_dash, clk, base0, base1, r0,r1,ignore);

initial
begin
clk = 1'b0;
//send = 1'b1;
recieve = 1'b1;
#2 
public_msg = 2'b00;
b_dash = 1'b0;

#4
public_msg = 2'b10;
b_dash = 1'b1;

#4 
public_msg = 2'b11;
b_dash = 1'b1;

#4 
public_msg = 2'b00;
b_dash = 1'b1;

#4
public_msg = 2'b11;
b_dash = 1'b0;

#4 
public_msg = 2'b01;
b_dash = 1'b1;

#4 
public_msg = 2'b01;
b_dash = 1'b0;

#4 
public_msg = 2'b10;
b_dash = 1'b0;



end

always #2 clk = clk + 1'b1;

endmodule
