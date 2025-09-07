`default_nettype none

module tt_um_mod6_counter (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

  // 3-bit Mod-6 counter
  reg [2:0] counter;

  always @(posedge clk) begin
    if (!rst_n)
      counter <= 3'd0;
    else if (counter == 3'd5)
      counter <= 3'd0;
    else
      counter <= counter + 1'b1;
  end

  // Assign outputs
  assign uo_out  = {5'b00000, counter};  // counter in lower 3 bits
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  // Suppress unused input warnings
  wire _unused = &{ui_in, uio_in, ena};

endmodule
