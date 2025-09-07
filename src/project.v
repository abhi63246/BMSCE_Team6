/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_mod6_counter (
    input  wire       clk,      // Clock
    input  wire       rst_n,    // Active-low reset
    input  wire       ena,      // Enable (always 1, can ignore)
    input  wire [7:0] ui_in,   // Not used in this counter
    input  wire [7:0] uio_in,  // Not used in this counter
    output wire [7:0] uo_out,  // 3-bit counter in lower bits
    output wire [7:0] uio_out, // Not used
    output wire [7:0] uio_oe   // Not used
);

  // 3-bit counter register
  reg [2:0] counter;

  // Sequential logic: counts from 0 to 5 and wraps around
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      counter <= 3'b000;  // Reset counter to 0
    else
      counter <= (counter == 3'd5) ? 3'b000 : counter + 1;
  end

  // Assign outputs
  assign uo_out  = {5'b0, counter}; // Only lower 3 bits used
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

endmodule
