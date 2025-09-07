`default_nettype none
`timescale 1ns / 1ps

/* This testbench instantiates the module and provides signals for cocotb.
   It also includes an assertion to check counter validity. */

module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // Clock and reset
  reg clk;
  reg rst_n;
  reg ena;

  // Inputs / Outputs
  reg  [7:0] ui_in;
  reg  [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  // DUT instantiation
  // Replace with your module name if different
  tt_um_mod6_counter user_project (
      .ui_in   (ui_in),     // Dedicated inputs
      .uo_out  (uo_out),    // Dedicated outputs
      .uio_in  (uio_in),    // IOs: Input path
      .uio_out (uio_out),   // IOs: Output path
      .uio_oe  (uio_oe),    // IOs: Enable path (active high: 0=input, 1=output)
      .ena     (ena),       // enable - goes high when design is selected
      .clk     (clk),       // clock
      .rst_n   (rst_n)      // not reset
  );

  // ========= Assertions =========
  // Ensure counter output (lower 3 bits) is always within 0–5 after reset
  property valid_counter_range;
    @(posedge clk) disable iff (!rst_n)
      (uo_out[2:0] <= 3'd5);
  endproperty

  assert property (valid_counter_range)
    else $error("Counter output invalid (X/Z or >5) at time %0t, value=%b",
                $time, uo_out[2:0]);

endmodule
