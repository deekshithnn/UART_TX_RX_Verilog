UART TX & RX in Verilog

A UART (Universal Asynchronous Receiver/Transmitter) communication system implemented in Verilog HDL. This project contains both UART Transmitter (TX) and UART Receiver (RX) modules and demonstrates reliable serial data transmission and reception through a TX-RX loopback connection.

🚀 Project Overview

UART is a simple asynchronous serial communication protocol widely used in embedded systems, microcontrollers, FPGAs, and digital systems.

This project implements:

- UART Transmitter (TX)
- UART Receiver (RX)
- TX-RX loopback communication
- Verilog RTL design
- Simulation testbenches
- Serial data verification
- Waveform-based functional verification

The transmitted data is sent from the UART TX module and connected directly to the UART RX module. The receiver reconstructs the original 8-bit data and provides it as received data.

---

🏗️ Project Architecture

             ┌─────────────────┐
             │                 │
   TX Data ─►│   UART TX       │
             │                 │
             └───────┬─────────┘
                     │
                     │ UART Serial Data
                     ▼
             ┌─────────────────┐
             │                 │
             │   UART RX       │◄── RX Clock
             │                 │
             └───────┬─────────┘
                     │
                     ▼
                RX Data

TX-RX Loopback

             UART TX
               │
               │ tx
               ▼
             UART RX
               │
               ▼
             rx_data

The "tx" output is directly connected to the "rx" input in the loopback testbench.

---

⚙️ UART Frame Format

The UART communication frame used in this project follows the standard asynchronous format:

Idle   Start    Data Bits              Stop
 1      0     D0 D1 D2 D3 D4 D5 D6 D7   1

Frame Components

Component| Description
Idle| TX line remains HIGH
Start Bit| Logic LOW
Data| 8-bit data
Stop Bit| Logic HIGH
Parity| Not used

The project uses 8-bit UART communication with 1 start bit and 1 stop bit.

---

🔧 Features

- Verilog HDL implementation
- Separate TX and RX logic
- 8-bit data transmission
- Asynchronous serial communication
- Start-bit detection
- Serial-to-parallel conversion
- Parallel-to-serial conversion
- TX-RX loopback testing
- Simulation-based verification
- Waveform analysis

---

📂 Repository Structure

UART_TX_RX_Verilog/
│
├── uart_tx.v
├── uart_rx.v
├── uart_tx_tb.v
├── uart_rx_tb.v
├── uart_loopback_tb.v
│
├── README.md
│
└── simulation/
    └── waveform/

«File names may differ depending on the final files uploaded to this repository.»

---

🧩 UART Transmitter

The UART transmitter converts an 8-bit parallel data byte into a serial UART frame.

TX Operation

Parallel Data
     │
     ▼
┌─────────────┐
│ UART TX     │
└──────┬──────┘
       │
       ▼
Serial TX Line

The transmitter performs the following sequence:

1. Waits for a transmission request.
2. Sends the start bit.
3. Sends the 8 data bits sequentially.
4. Sends the stop bit.
5. Returns to the idle state.

---

🧩 UART Receiver

The UART receiver converts the incoming serial UART frame back into 8-bit parallel data.

RX Operation

Serial RX Line
      │
      ▼
┌─────────────┐
│ UART RX     │
└──────┬──────┘
       │
       ▼
  8-bit RX Data

The receiver:

1. Detects the start bit.
2. Samples the incoming serial data.
3. Captures the 8 data bits.
4. Detects the stop bit.
5. Produces the received 8-bit data.

---

🔄 Loopback Test

The loopback test connects the transmitter directly to the receiver:

TX → RX

For example, if the transmitter sends:

TX Data = 8'hA5

The receiver should produce:

RX Data = 8'hA5

Example Verification

TX Data : A5
TX      : Serial UART waveform
RX      : Serial UART waveform
RX Data : A5

This confirms that the transmitted data was successfully received.

---

🧪 Simulation & Verification

The design can be simulated using tools such as:

- Xilinx Vivado
- Icarus Verilog
- GTKWave
- ModelSim/QuestaSim

Verification Process

1. Generate the clock.
2. Apply reset.
3. Provide an 8-bit TX data value.
4. Start UART transmission.
5. Connect TX output to RX input.
6. Monitor RX data.
7. Compare TX data and RX data.
8. Verify the waveform.

Example Test Data

TX Data = 8'hA5
RX Data = 8'hA5

The successful reception of "A5" confirms correct TX-RX loopback operation.

---

📊 Expected Result

+----------------+----------------+
| Parameter      | Result         |
+----------------+----------------+
| TX Data        | 8'hA5          |
| TX Serial Data | UART Frame     |
| RX Serial Data | UART Frame     |
| RX Data        | 8'hA5          |
| Status         | PASS           |
+----------------+----------------+

The simulation demonstrates that the receiver successfully reconstructs the data transmitted by the UART transmitter.

---

🛠️ Technologies Used

- Verilog HDL
- RTL Design
- Digital Logic Design
- UART Protocol
- FPGA Design
- Simulation & Verification
- Waveform Analysis

Tools

- Xilinx Vivado
- Verilog Simulator
- GTKWave / Vivado Waveform Viewer

---

📚 Concepts Learned

Through this project, the following concepts were practiced:

- UART communication
- Serial communication
- Parallel-to-serial conversion
- Serial-to-parallel conversion
- FSM-based RTL design
- Clocked sequential logic
- Reset handling
- Testbench development
- Simulation and waveform debugging
- Hardware verification

---

🔮 Future Improvements

The project can be extended with:

- [ ] Configurable baud rate
- [ ] Parameterized clock frequency
- [ ] Configurable data width
- [ ] Parity bit support
- [ ] Multiple stop-bit configurations
- [ ] TX/RX status flags
- [ ] FIFO buffering
- [ ] FPGA hardware implementation
- [ ] UART communication with a PC
- [ ] Error detection and framing-error handling

---

🎯 Applications

UART is commonly used in:

- Microcontrollers
- FPGA systems
- Embedded systems
- Debug interfaces
- GPS modules
- Bluetooth modules
- GSM modules
- Serial terminals
- Sensor communication

---

👨‍💻 Author

Deekshith N N

Electronics & Communication Engineering

GitHub:
https://github.com/d0439031-star

---

⭐ Project

If you find this project useful for learning Verilog, UART, RTL design, or FPGA development, consider giving the repository a ⭐.

---

📜 License

This project is intended for educational and learning purposes.UART TX-RX Loopback Communication using Verilog
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
