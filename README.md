# Verilog-SPI-Controller

 This project aims to implement SPI master and slave modules and data transmission between them using Verilog. SPI master module is designed as a Finite state machine (FSM). The slave module is a simple shift register.
 
 ## Software Used
 
 1. Xilinx Vivado
 
 ## HDL Used : Verilog 

## Finite State Machine 

### 1. Transmitter

• First three outputs are directly associated with SPI lines, fourth output shows the
  module is busy with transmitting data
  
• SCK is set as 2 MHz CPOL and CPHA are set as zero

• This module is a state machine triggered at every falling edge of SCK

• Initially state machine at RDY state;

• When send ==1; data transmission

• START state; set SS as logic level 0 data loaded at MOSI line.

• TRANSMIT state; data send to out via MOSI step by step

• Finally, when index =0; iteration ends

• STOP state;

### 2. Receiver

• Initial RDY state

• Module checks SS to become logic level 0 at a every rising edge of SCK

• Index decrease by one

• When SS is zero module set to receive data from MOSI

• RECEIVE state; Module receive data from every clock cycle

• When index =0; machine goes to stop state
