`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2026 21:25:45
// Design Name: 
// Module Name: uart_rx
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


module uart_rx #(
    parameter CLK_FREQ  = 50_000_000,
    parameter BAUD_RATE = 9_600
)(
    input  wire       clk,
    input  wire       rst,
    input  wire       rx,

    output reg [7:0]  rx_data,
    output reg        rx_done
);

    localparam integer CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

    localparam [2:0]
        IDLE  = 3'd0,
        START = 3'd1,
        DATA  = 3'd2,
        STOP  = 3'd3;

    reg [2:0] state;

    reg [15:0] clk_count;
    reg [2:0]  bit_count;
    reg [7:0]  rx_shift_reg;

    always @(posedge clk) begin

        if (rst) begin
            state        <= IDLE;
            clk_count    <= 16'd0;
            bit_count    <= 3'd0;
            rx_shift_reg <= 8'd0;
            rx_data      <= 8'd0;
            rx_done      <= 1'b0;
        end

        else begin

            // Default: rx_done is active for one clock cycle
            rx_done <= 1'b0;

            case (state)

                // --------------------------------
                // IDLE STATE
                // --------------------------------
                IDLE: begin
                    clk_count <= 16'd0;
                    bit_count <= 3'd0;

                    // Detect START bit
                    if (rx == 1'b0) begin
                        state <= START;
                    end
                end


                // --------------------------------
                // START BIT
                // --------------------------------
                START: begin

                    if (clk_count < (CLKS_PER_BIT / 2) - 1) begin
                        clk_count <= clk_count + 1;
                    end

                    else begin
                        clk_count <= 16'd0;

                        // Confirm start bit
                        if (rx == 1'b0) begin
                            state <= DATA;
                        end
                        else begin
                            state <= IDLE;
                        end
                    end
                end


                // --------------------------------
                // DATA BITS
                // --------------------------------
                DATA: begin

                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end

                    else begin
                        clk_count <= 16'd0;

                        // Receive data LSB first
                        rx_shift_reg[bit_count] <= rx;

                        if (bit_count < 7) begin
                            bit_count <= bit_count + 1;
                        end
                        else begin
                            bit_count <= 3'd0;
                            state <= STOP;
                        end
                    end
                end


                // --------------------------------
                // STOP BIT
                // --------------------------------
                STOP: begin

                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end

                    else begin
                        clk_count <= 16'd0;

                        // Check STOP bit
                        if (rx == 1'b1) begin
                            rx_data <= rx_shift_reg;
                            rx_done <= 1'b1;
                        end

                        state <= IDLE;
                    end
                end


                default: begin
                    state <= IDLE;
                end

            endcase
        end
    end

endmodule
