// TITLE: sync_keyboard.sv
// PROJECT: Keyboard VLSI lab
// DESCRIPTION: Synchronize keyboard clock and data to system clock

`timescale 1ns/1ps

module sync_keyboard (
    input logic clk,
    input logic kb_clk,
    input logic kb_data,
    output logic kb_clk_sync,
    output logic kb_data_sync
    );
    
logic kb_data_tmp;
logic kb_clk_tmp;

always_ff @(posedge clk) begin : synchroniser
    kb_data_tmp <= kb_data;
    kb_clk_tmp <= kb_clk;
    
    kb_data_sync <= kb_data_tmp;
    kb_clk_sync <= kb_clk_tmp;
end

endmodule
