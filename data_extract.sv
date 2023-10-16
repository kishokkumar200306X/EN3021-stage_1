module data_extract #(parameter WIDTH = 32)
    (input logic [WIDTH-1:0] inst,
     input logic [WIDTH-1:0] data,
     output logic [WIDTH-1:0] y);

    logic [31:0] Imm_out;
    logic [15:0] s_bit;
    logic [7:0] e_bit;

    assign s_bit = data[15:0];
    assign e_bit = data[7:0];

    always_ff @(*) begin
        Imm_out = {inst[31]? {20{1'b1}} : {20{1'b0}}, inst[31:20]};
    end

    always_ff @(*) begin
        if (inst[6:0] == 7'b0000011) begin
            if (inst[14:12] == 3'b000)
                y <= {e_bit[7] ? {24{1'b1}} : {24{1'b0}}, e_bit};
            else if (inst[14:12] == 3'b001)
                y <= {s_bit[15] ? {16{1'b1}} : {16{1'b0}}, s_bit};
            else if (inst[14:12] == 3'b100)
                y <= {24'b0, e_bit};
            else if (inst[14:12] == 3'b101)
                y <= {16'b0, s_bit};
            else if (inst[14:12] == 3'b010)
                y <= data;
        end else if (inst[6:0] == 7'b0100011) begin
            if (inst[14:12] == 3'b000)
                y <= {e_bit[7] ? {24{1'b1}} : {24{1'b0}}, e_bit};
            else if (inst[14:12] == 3'b001)
                y <= {s_bit[15] ? {16{1'b1}} : {16{1'b0}}, s_bit};
            else if (inst[14:12] == 3'b010)
                y <= data;
        end
    end
endmodule
