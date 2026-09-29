// TITLE: keyboard_ctrl.sv
// PROJECT: Keyboard VLSI lab
// DESCRIPTION: Controller to handle the scan codes

`timescale 1ns/1ps

module keyboard_ctrl (
    input logic clk,
    input logic rst,
    input logic valid_code,
    input logic [7:0] scan_code_in,
    output logic [7:0] code_to_display,
    output logic [3:0] seg_en
    );
    
typedef enum logic {IDLE, WAIT_FOR_RELEASE_CODE} state_t;

logic [15:0] cycle_counter;
logic [1:0] num_cycles;
logic [7:0] digits [3:0];
logic [7:0] digits_next [3:0];
logic [1:0] valid_key_release;


state_t state, state_next;


always_ff @(posedge clk) begin
    if (rst) begin
        cycle_counter <= 1'b0;
        state <= IDLE;
        num_cycles <= 2'b00;
        digits[0] <= 8'h00;
        digits[1] <= 8'h00;
        digits[2] <= 8'h00;
        digits[3] <= 8'h00;
                
    end else begin
        state <= state_next;
        digits[3] <= digits_next[3];
        digits[2] <= digits_next[2];
        digits[1] <= digits_next[1];
        digits[0] <= digits_next[0];

        if (cycle_counter == 16'h00FF) begin
            num_cycles <= num_cycles + 1'b1;
            cycle_counter <= 1'b0;
            
        end else begin
            cycle_counter <= cycle_counter + 1'b1;
        end
    end
end

always_comb begin
    state_next = state;
    digits_next[0] = digits[0];
    digits_next[1] = digits[1];
    digits_next[2] = digits[2];
    digits_next[3] = digits[3];

    if (valid_code) begin
        case (state)
            IDLE: begin
                if (scan_code_in == 8'hf0) begin
                    state_next = WAIT_FOR_RELEASE_CODE;
                end
            end
            WAIT_FOR_RELEASE_CODE: begin
                // Key released
                digits_next[3] = digits[2];
                digits_next[2] = digits[1];
                digits_next[1] = digits[0];
                digits_next[0] = scan_code_in;
                state_next = IDLE;
            end
            
            default: state_next = IDLE;
        endcase
    end

    case (num_cycles)
        2'b00: begin
            seg_en = 4'b1110;
            code_to_display = digits[0];
        end
        2'b01: begin
            seg_en = 4'b1101;
            code_to_display = digits[1];
        end
        2'b10: begin
            seg_en = 4'b1011;
            code_to_display = digits[2];
        end
        2'b11: begin
            seg_en = 4'b0111;
            code_to_display = digits[3];
        end
        default: begin
            seg_en = 4'b1111;
            code_to_display = 8'hFF;
        end
    endcase
end
endmodule
