// TITLE: binary_to_sgd.sv
// PROJECT: Keyboard VLSI lab
// DESCRIPTION: Simple look-up table

`timescale 1ns/1ps

module binary_to_sg (
    input logic [3:0] binary_in,
    output logic [7:0] sev_seg
    );
    
    always_comb begin
        case (binary_in)
            4'b0001: sev_seg = 8'b11111001; //1
            4'b0010: sev_seg = 8'b10100100; //2
            4'b0011: sev_seg = 8'b10110000; //3
            4'b0100: sev_seg = 8'b10011001; //4
            4'b0101: sev_seg = 8'b10010010; //5
            4'b0110: sev_seg = 8'b10000010; //6
            4'b0111: sev_seg = 8'b11111000; //7
            4'b1000: sev_seg = 8'b10000000; //8
            4'b1001: sev_seg = 8'b10010000; //9
            4'b0000: sev_seg = 8'b11000000; //0
            default: sev_seg = 8'b10000110; //E
        endcase
    end

endmodule
