
module Pcounter(
  input logic clk, reset, // Clock and reset inputs
  input logic [31:0] PC_in, // 32-bit input
  output logic [31:0] PC_out // 32-bit output
);

always_ff @(posedge clk) begin
  if (reset)
    PC_out <= 32'h00000000; // If reset is asserted, set PC_out to all zeros
  else
    PC_out <= PC_in; // If reset is de-asserted, copy PC_in to PC_out
end

endmodule


