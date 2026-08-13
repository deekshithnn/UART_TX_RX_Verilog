`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2026 21:47:44
// Design Name: 
// Module Name: uart_loopback_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps

module uart_loopback_tb;

    // ==========================================
    // PARAMETERS
    // ==========================================
    parameter CLK_FREQ  = 50_000_000;
    parameter BAUD_RATE = 9_600;

    // ==========================================
    // TESTBENCH SIGNALS
    // ==========================================
    reg        clk;
    reg        rst;

    reg        tx_start;
    reg [7:0]  tx_data;

    wire       tx;
    wire       tx_busy;

    wire [7:0] rx_data;
    wire       rx_done;


    // ==========================================
    // CLOCK GENERATION
    // 50 MHz clock = 20 ns period
    // ==========================================
    always #10 clk = ~clk;


    // ==========================================
    // UART TRANSMITTER
    // ==========================================
    uart_tx #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) TX (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );


    // ==========================================
    // UART RECEIVER
    // ==========================================
    uart_rx #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) RX (
        .clk(clk),
        .rst(rst),
        .rx(tx),              // TX connected to RX
        .rx_data(rx_data),
        .rx_done(rx_done)
    );


    // ==========================================
    // TEST SEQUENCE
    // ==========================================
    initial begin

        // Initial values
        clk      = 1'b0;
        rst      = 1'b1;
        tx_start = 1'b0;
        tx_data  = 8'h00;

        // Reset
        #100;
        rst = 1'b0;

        // ======================================
        // TEST 1: SEND 0x55
        // ======================================

        #100;

        tx_data  = 8'h55;
        tx_start = 1'b1;

        #20;
        tx_start = 1'b0;

        // Wait until transmission finishes
        wait(tx_busy == 1'b0);

        // Small delay
        #1000;


        // ======================================
        // TEST 2: SEND 0xA5
        // ======================================

        tx_data  = 8'hA5;
        tx_start = 1'b1;

        #20;
        tx_start = 1'b0;

        wait(tx_busy == 1'b0);

        #1000;


        // ======================================
        // END SIMULATION
        // ======================================

        $display("====================================");
        $display("UART LOOPBACK TEST COMPLETED");
        $display("====================================");

        $finish;

    end


    // ==========================================
    // MONITOR RX DATA
    // ==========================================
    always @(posedge rx_done) begin

        $display(
            "TIME = %0t | RX DATA = %h",
            $time,
            rx_data
        );

    end

endmodule
