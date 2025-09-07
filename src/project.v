`default_nettype none

module tt_um_mod6_counter (
    input  wire       clk,      // clock
    input  wire       rst_n,    // active low reset
    input  wire       ena,      // enable (always high)
    input  wire [7:0] ui_in,    // dedicated input
    input  wire [7:0] uio_in,   // IO input path
    output reg  [7:0] uo_out,   // dedicated output
    output reg  [7:0] uio_out,  // IO output path
    output reg  [7:0] uio_oe    // IO output enable
);

  reg [2:0] counter;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 3'd0;
      uo_out  <= 8'd0;
      uio_out <= 8'd0;
      uio_oe  <= 8'd0;
    end else if (ena) begin
      if (counter == 3'd5) begin
        counter <= 3'd0;
        uo_out  <= 8'd0;
      end else begin
        counter <= counter + 3'd1;
        uo_out  <= counter + 3'd1;   // ✅ use next value
      end
      uio_out <= 8'd0;
      uio_oe  <= 8'd0;
    end
  end

endmodule
