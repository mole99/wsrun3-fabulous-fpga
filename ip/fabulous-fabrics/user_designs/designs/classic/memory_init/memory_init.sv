// SPDX-FileCopyrightText: © 2026 Leo Moser
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module memory_init #(
    parameter WORD_BITS = 8,
    parameter ADDR_BITS = 10
)(
    input  wire       clk1,
    
    input  wire [ADDR_BITS-1:0] addr,
    output wire [WORD_BITS-1:0] data_o
);
    logic [7:0] mem [2**ADDR_BITS];
    
    initial begin
        $readmemh("lorem_ipsum.hex", mem);
    end
    
    always @(posedge clk1) begin
        data_o <= mem[addr];
    end

endmodule
