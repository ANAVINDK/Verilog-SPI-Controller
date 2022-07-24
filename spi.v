module SPI_Master_Transmitter(clk,data,send,sck,ss,mosi,busy);
parameter data_length =8;

input clk;
input [data_length-1:0] data;
input send;
output reg sck=0;
output reg ss =1;
output reg mosi=0;
output reg busy =0;

localparam RDY=2'b00; localparam START =2'b01;localparam TRANSMIT=2'b10;localparam STOP =2'b11;

reg [1:0] state = RDY;
reg [7:0] clkdiv = 0;
reg [7:0] index =  0;

always @ (posedge clk)

if(clkdiv == 8'd24)
	begin
	clkdiv<=0;
	sck<= ~sck;
	end
else clkdiv <= clkdiv + 1;

always @(negedge sck)

case(state)
RDY:
	if(send)
	begin
	busy <= 1;
	state <= START;
	index <= data_length-1;
    end
START:
      begin
	  ss <= 0;
	  mosi <= data[index];
	  index <= index-1;
	  state <= TRANSMIT;
	  end

TRANSMIT:
	     begin
	     if(index==0)
	     state <=STOP;
         else mosi<=data[index];
	     index <= index-1;
	     end
	
STOP:
	begin
	busy <= 0;
	ss <= 1;
	state <= RDY;
	end
endcase
endmodule





module SPI_Slave_receiver(sck,ss,mosi,data,busy,ready);

parameter data_length=8;
input sck;
input ss;
input mosi;
output reg[data_length-1:0] data;
output reg busy=0;
output reg ready=0;

localparam RDY=2'b00,RECEIVE=2'b01,STOP=2'b10;
reg[1:0] state=RDY;

reg [data_length-1:0] data_temp=0;
reg[7:0] index=data_length-1;

always@(posedge sck)

case(state)
RDY:
       if(!ss)
        begin
        busy <= 1;
        data_temp[index]<= mosi;
        index <= index - 1;
        ready <= 0;
        state <= RECEIVE;
        end
RECEIVE:        
        begin
        if(index==0)
        state <= STOP;
        else index <= index-1;
        data_temp[index] <= mosi;
        end
STOP:
        begin
        busy <= 0;
        ready<= 1;
        data <= data_temp;
        data_temp <= 0;
        index <= data_length-1;
        state <= RDY;
        end
endcase
endmodule


module SPI_Protocol(clk,send,send_data,received_data,master_busy,slave_busy,ready);
input clk,send;
input[7:0]send_data;
output [7:0]received_data;
output master_busy,slave_busy,ready;
wire sck,ss,mosi;

 SPI_Master_Transmitter SPImaster (
    .clk(clk),
    .data(send_data),
    .send(send),
    .sck(sck),
    .ss(ss),
    .mosi(mosi),
    .busy(master_busy)
  );
  
  
 SPI_Slave_receiver SPIslave (
    .sck(sck),
    .ss(ss),
    .mosi(mosi),
    .data(received_data),
    .busy(slave_busy),
    .ready(ready)
  );
  
  
  

  
endmodule  









        


module SPI_Protocol(clk,send,send_data,received_data,master_busy,slave_busy,ready);
input clk,send;
input[7:0]send_data;
output [7:0]received_data;
output master_busy,slave_busy,ready;
wire sck,ss,mosi;

 SPI_Master_Transmitter SPImaster (
    .clk(clk),
    .data(send_data),
    .send(send),
    .sck(sck),
    .ss(ss),
    .mosi(mosi),
    .busy(master_busy)
  );
  
  
 SPI_Slave_receiver SPIslave (
    .sck(sck),
    .ss(ss),
    .mosi(mosi),
    .data(received_data),
    .busy(slave_busy),
    .ready(ready)
  );
  
  
  
endmodule  