UART TX-RX Loopback Communication using Verilog
A digital UART communication project designed and simulated using Verilog HDL and Xilinx Vivado. The project implements a UART Transmitter (TX), UART Receiver (RX), and a loopback testbench to verify serial data transmission and reception.
Project Overview
The project demonstrates a complete UART communication path:
TX DATA
           |
           v
   +---------------+
   | UART          |
   | Transmitter   |
   +-------+-------+
           |
           | Serial TX
           v
   +---------------+
   | UART          |
   | Receiver      |
   +-------+-------+
           |
           v
        RX DATA
In loopback simulation, the transmitter output is directly connected to the receiver input.
Features
Verilog RTL implementation
UART Transmitter
UART Receiver
8-bit data transmission
1 start bit
1 stop bit
LSB-first transmission
50 MHz system clock
9600 baud rate
TX-RX loopback verification
Vivado behavioral simulation
Testbench-based functional verification
UART Configuration
Parameter               Value
Clock Frequency        50 MHz Baud Rate                9600 Data Bits                   8 Start Bits                  1 Stop Bits                   1 Parity                   None Data Order          LSB First
Project Structure
UART-TX-RX-Verilog/
│
├── rtl/
│   ├── uart_tx.v
│   └── uart_rx.v
│
├── simulation/
│   ├── uart_tx_tb.v
│   ├── uart_rx_tb.v
│   └── uart_loopback_tb.v
│
├── screenshots/
│   └── uart_loopback_waveform.png
│
└── README.md
Modules
UART Transmitter
The transmitter accepts an 8-bit parallel input and converts it into a serial UART frame.
Start Bit -> 8 Data Bits -> Stop Bit
    0     ->   LSB First  ->    1
UART Receiver
The receiver detects the start bit, samples the incoming serial data, reconstructs the 8-bit byte, checks the stop bit, and asserts rx_done when valid data has been received.
Loopback Testbench
The loopback testbench connects:
TX.tx -> RX.rx
This allows the transmitted byte to be received by the UART receiver without external hardware.
Verification
The loopback testbench was used to verify UART communication.
Test Case
Transmitted Data: 0xA5
Received Data:    0xA5
Result:
PASS
The successful reception of 0xA5 confirms that the TX-to-RX loopback path is functioning in simulation.
Simulation Waveform
Add your Vivado waveform screenshot to:
screenshots/uart_loopback_waveform.png
The waveform should show signals such as:
clk
rst
tx_start
tx_data
tx
rx_data
rx_done
Tools Used
Verilog HDL
Xilinx Vivado
XSim Behavioral Simulator
RTL Design
Digital Logic Design
Learning Outcomes
Through this project, I learned:
UART serial communication
RTL design using Verilog
Sequential logic
Baud-rate timing
Shift-register based serial transmission
FSM-style receiver control
Verilog testbench development
Loopback verification
Reading and analyzing simulation waveforms
Debugging Vivado simulation errors
Future Improvements
Add UART parity support
Add configurable stop bits
Implement UART RX oversampling
Add input synchronizer for RX
Add FIFO buffering
Add AXI4-Lite interface
Implement the design on an FPGA board
Measure synthesis resource utilization and timing
Author
Deekshith N N
Electronics and Communication Engineering
Keywords
Verilog UART RTL Design VLSI FPGA Vivado XSim Digital Design Serial Communication
