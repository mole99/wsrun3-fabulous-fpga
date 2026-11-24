// SPDX-FileCopyrightText: © 2026 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

// Please note that this is a test module
// hardcoded just for this fabric.
// It should not be used for other fabrics as is.

module memory_config #(
    parameter NUM_MEMORIES = 1,
    
    parameter MEMORY_DATA_WIDTH = 8,
    parameter MEMORY_ADDR_WIDTH = 8,
    
    parameter [4:0] X_COORDS [NUM_MEMORIES-1:0] = '{0},
    parameter [4:0] Y_COORDS [NUM_MEMORIES-1:0] = '{0}
)(
    input logic clk_i,
    input logic rst_ni,

    // Coordinates
    input logic [4:0] memory_coord_x_i,
    input logic [4:0] memory_coord_y_i,
    input logic       memory_coord_valid_i,
    
    // Data
    input logic [30:0] memory_data_i,
    input logic        memory_data_valid_i,
    
    // Output ports to memories
    output logic [NUM_MEMORIES-1:0] sram_config_enable_o,
    output logic sram_config_we_o,
    output logic [MEMORY_ADDR_WIDTH-1:0] sram_config_address_o,
    output logic [MEMORY_DATA_WIDTH-1:0] sram_config_data_o
);
    
    logic [MEMORY_ADDR_WIDTH-1:0] counter;
    logic [NUM_MEMORIES-1:0] sram_selected;
    
    always_ff @(posedge clk_i) begin
        if (!rst_ni) begin
            counter <= '0;
            for (int i=0; i<NUM_MEMORIES; i++) begin
                sram_selected[i] <= 1'b0;
            end
        end else begin
        
            if (memory_coord_valid_i) begin
                counter <= '0;
                for (int i=0; i<NUM_MEMORIES; i++) begin
                    sram_selected[i] <= 1'b0;
                end
                // Find the SRAM that is selected, last one wins
                for (int i=0; i<NUM_MEMORIES; i++) begin
                    sram_selected[i] <= 1'b0;
                    if (memory_coord_x_i == X_COORDS[i] && memory_coord_y_i == Y_COORDS[i]) begin
                        sram_selected[i] <= 1'b1;
                    end
                end
            end
            
            // For as long as we get data, increment
            // the address and write the data
            if (memory_data_valid_i) begin
                counter <= counter + 1;
            end
        end
    end
    
    assign sram_config_address_o = counter;
    assign sram_config_data_o = memory_data_i;
    assign sram_config_we_o = memory_data_valid_i;
    
    generate
    for (genvar i=0; i<NUM_MEMORIES; i++) begin
        assign sram_config_enable_o[i] = sram_selected[i];
    end
    endgenerate
    
endmodule
