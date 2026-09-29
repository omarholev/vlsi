// TITLE: convert_scancode.sv
// PROJECT: Keyboard VLSI lab
// DESCRIPTION: Implement a shift register to convert serial to parallel
// A counter to flag when the valid code is shifted in

`timescale 1ns/1ps

module convert_scancode (
    input logic clk,
    input logic rst,
    input logic edge_found,
    input logic serial_data,
    output logic valid_scan_code,
    output logic [7:0] scan_code_out
    );
    
   
logic [9:0] shift_reg;
logic [3:0] bit_count;

logic valid_code_next;
logic [7:0] scan_code_next;
logic [3:0] bit_count_next;
logic [9:0] shift_reg_next;

logic valid_code_reg;
logic [7:0] scan_code_reg;


assign scan_code_out = scan_code_reg;
assign valid_scan_code = valid_code_reg;

always_ff @(posedge clk) begin
    if (rst) begin
        shift_reg <= 11'b0;
        valid_code_reg <= 1'b0;
        scan_code_reg <= 8'b0;
        bit_count <= 4'b0;
    end else begin
        shift_reg <= shift_reg_next;
        bit_count <= bit_count_next;
        scan_code_reg <= scan_code_next;
        valid_code_reg <= valid_code_next;
    end
end

always_comb begin
    shift_reg_next = shift_reg;
    bit_count_next = bit_count;
    scan_code_next = scan_code_out;
    valid_code_next = 1'b0;
    
    if (edge_found) begin
        shift_reg_next = {serial_data, shift_reg[9:1]};
        if (bit_count == 4'd10) begin
            bit_count_next = 4'd0;
            scan_code_next = shift_reg[8:1];
            valid_code_next = 1'b1;
        end else begin
            bit_count_next = bit_count + 1'b1;
        end        
    end
end



endmodule
