/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_mod6_counter (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // 3-bit Mod-6 counter (counts 0 to 5)
  reg [2:0] counter;

  always @(posedge clk) begin
    if (!rst_n)
      counter <= 3'd0;                    // Async reset (active low)
    else if (counter == 3'd5)
      counter <= 3'd0;                    // Reset after reaching 5
    else
      counter <= counter + 1'b1;          // Increment
  end

  // Assign counter value to output bits [2:0], others set to 0
    assign uo_out = {5'b00000, counter};
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ui_in, uio_in, ena};

endmodule
