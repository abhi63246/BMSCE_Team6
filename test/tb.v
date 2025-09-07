`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // Inputs
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;

  // Outputs
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  // DUT instantiation
  tt_um_mod6_counter user_project (
      .clk     (clk),
      .rst_n   (rst_n),
      .ena     (ena),
      .ui_in   (ui_in),
      .uio_in  (uio_in),
      .uo_out  (uo_out),
      .uio_out (uio_out),
      .uio_oe  (uio_oe)
  );

endmodule
