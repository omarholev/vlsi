// TITLE: convert_to_binary.sv
// PROJECT: Keyboard VLSI lab
// DESCRIPTION: Look-up-table

`timescale 1ns/1ps

module convert_to_binary (
    input logic [7:0] scan_code_in,
    output logic [3:0] binary_out
    );
    // Simple combinational logic using case statements (LUT)
    always_comb begin
        case (scan_code_in)
            8'h16: binary_out = 4'b0001; //1
            8'h1E: binary_out = 4'b0010; //2
            8'h26: binary_out = 4'b0011; //3
            8'h25: binary_out = 4'b0100; //4
            8'h2E: binary_out = 4'b0101; //5
            8'h36: binary_out = 4'b0110; //6
            8'h3D: binary_out = 4'b0111; //7
            8'h3E: binary_out = 4'b1000; //8
            8'h46: binary_out = 4'b1001; //9
            8'h45: binary_out = 4'b0000; //0
            default: binary_out = 4'b1111; //E
         endcase        
    end
    
    
    
    
endmodule
