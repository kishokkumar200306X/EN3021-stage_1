module datamemory #(
    parameter DM_ADDRESS = 9,
    parameter DATA_W = 32
)(
    input logic clk,
    input logic MemRead, // Asynchronous read signal from the control unit
    input logic MemWrite, // Synchronous write signal from the control unit
    input logic [DM_ADDRESS-1:0] a, // Asynchronous Read/Write address
    input logic [DATA_W-1:0] wd, // Synchronous Write Data
    output logic [DATA_W-1:0] rd // Asynchronous Read Data
);

    logic [DATA_W-1:0] mem[(1 << DM_ADDRESS)-1:0];

    // Asynchronous read
    always_ff @(posedge clk) begin
        if (MemRead)
            rd <= mem[a];
    end

    // Synchronous write on the rising edge of the clock
    always_ff @(posedge clk) begin
        if (MemWrite)
            mem[a] <= wd;
    end

endmodule
