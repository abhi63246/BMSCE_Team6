`default_nettype none
`timescale 1ns / 1ps

/* Testbench for tt_um_mod6_counter
   Instantiates the module and connects signals for simulation or cocotb testing.
*/
module tb ();

  // Dump the signals to a VCD file
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

  // Optional power pins for gate-level test
`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Instantiate the Mod-6 counter
  tt_um_mod6_counter user_project (

`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (ui_in),
      .uo_out (uo_out),
      .uio_in (uio_in),
      .uio_out(uio_out),
      .uio_oe (uio_oe),
      .ena    (ena),
      .clk    (clk),
      .rst_n  (rst_n)
  );

  // Optional: simple clock generator for simulation
  initial clk = 0;
  always #5 clk = ~clk; // 100 MHz clock for example

  // Optional: initialize signals
  initial begin
    rst_n = 0;
    ena   = 1;
    ui_in = 8'd0;
    uio_in= 8'd0;
    #20;
    rst_n = 1; // release reset after some cycles
  end

endmodule
