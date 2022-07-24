`timescale 1ns / 1ps


module SPI_tb();
 reg clk=0;
 reg send=0;
 reg [7:0]send_data=0;
  wire [7:0]received_data;
  wire master_busy;
  wire slave_busy;
  wire ready;
 
 SPI_Protocol SPI1(.clk(clk),.send(send),.send_data(send_data),.received_data(received_data),.master_busy(master_busy),.slave_busy(slave_busy),.ready(ready));
 
 
 initial
begin
clk = 0;
send = 0;
end

 initial begin
    clk = 1'b0;
    forever #1 clk = ~clk;
  end


initial
   begin
   send=1'b1;
   #10;
   send_data = 8'b10101011;
   #5;
   end   
 endmodule