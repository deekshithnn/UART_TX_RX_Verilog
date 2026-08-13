`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2026 09:05:45
// Design Name: 
// Module Name: uart_tx
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

 `timescale 1ns / 1ps

module uart_tx(
    input clk,
    input rst,
    input start,
    input [7:0] data_in,
    output reg tx,
    output reg busy
);

reg [3:0] bit_count;
reg [7:0] data_reg;

parameter IDLE  = 2'b00,
          START = 2'b01,
          DATA  = 2'b10,
          STOP  = 2'b11;

reg [1:0] state;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        tx <= 1'b1;
        busy <= 1'b0;
        bit_count <= 0;
        data_reg <= 0;
    end
    else begin
        case(state)

        IDLE: begin
            tx <= 1'b1;
            busy <= 1'b0;
            if(start) begin
                data_reg <= data_in;
                state <= START;
                busy <= 1'b1;
            end
        end

        START: begin
            tx <= 1'b0;
            bit_count <= 0;
            state <= DATA;
        end

        DATA: begin
            tx <= data_reg[0];
            data_reg <= data_reg >> 1;
            if(bit_count == 7)
                state <= STOP;
            else
                bit_count <= bit_count + 1;
        end

        STOP: begin
            tx <= 1'b1;
            busy <= 1'b0;
            state <= IDLE;
        end

        endcase
    end
end

endmodule        

