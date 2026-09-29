// TITLE: edge_detector.sv
// PROJECT: Keyboard VLSI lab
// DESCRIPTION: Make sure not to use posedge/negedge on any other signal than clk

`timescale 1ns/1ps

module edge_detector (
    input logic clk,
    input logic rst,
    input logic kb_clk_sync,
    output edge_found
    );
    
    logic kb_clk_delay;
    
    always_ff  @(posedge clk) begin
        if (rst) begin
            kb_clk_delay <= 1'b0; // Migh be supposed to start at 1
        end else begin
            kb_clk_delay <= kb_clk_sync;
        end
    end
    
    assign edge_found = !kb_clk_sync && kb_clk_delay;

endmodule
