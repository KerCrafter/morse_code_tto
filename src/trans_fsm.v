module trans_fsm(
    dot_inp, 
    dash_inp, 
    char_space_inp, 
    word_space_inp,
    parallel_out, 
    clk,
    rst
);

//////////////  INPUTS   /////////////////
input dot_inp;
input dash_inp;
input char_space_inp;
input word_space_inp;
input clk;
input rst;

//////////// OUTPUTS /////////////////
output reg [2:0] parallel_out;

////////// parameters /////////
// Main States
parameter [3:0] s_idle       = 4'b0000;
parameter [3:0] s_dot        = 4'b0001;
parameter [3:0] s_dash       = 4'b0010;

// 3-Unit Character Space States
parameter [3:0] s_char_1     = 4'b0100;
parameter [3:0] s_char_2     = 4'b0101;
parameter [3:0] s_char_3     = 4'b0110;

// 7-Unit Word Space States
parameter [3:0] s_word_1     = 4'b1000;
parameter [3:0] s_word_2     = 4'b1001;
parameter [3:0] s_word_3     = 4'b1010;
parameter [3:0] s_word_4     = 4'b1011;
parameter [3:0] s_word_5     = 4'b1100;
parameter [3:0] s_word_6     = 4'b1101;
parameter [3:0] s_word_7     = 4'b1110;

// We need separate registers for current state and next state
reg [3:0] state, next_state; 

// PROCESS 1: Sequential Block for State Transitions
// This block only describes the behavior of the state flip-flops.
always@(posedge clk or negedge rst)
begin
    if(!rst) begin
        state <= s_idle;
    end
    else begin
        state <= next_state;
    end
end

// PROCESS 2: Combinational Block for Next State and Output Logic
// This block calculates the next state and outputs based on the current state and inputs.
always@(*)
begin
    // Default assignments to prevent inferring latches
    next_state = s_idle;
    parallel_out = 3'b000; // Default output for idle state

    case(state)
        s_idle:
        begin
            parallel_out = 3'b000; // Inter-element space
            if (dot_inp)
                next_state = s_dot;
            else if (dash_inp)
                next_state = s_dash;
            else if (char_space_inp)
                next_state = s_char_1; // Start the 3-cycle character space
            else if (word_space_inp)
                next_state = s_word_1; // Start the 7-cycle word space
            else
                next_state = s_idle;
        end

        s_dot:  begin parallel_out = 3'b001; next_state = s_idle; end
        s_dash: begin parallel_out = 3'b010; next_state = s_idle; end

        // --- Character Space Sequence (3 cycles) ---
        s_char_1: begin parallel_out = 3'b011; next_state = s_char_2; end
        s_char_2: begin parallel_out = 3'b011; next_state = s_char_3; end
        s_char_3: begin parallel_out = 3'b011; next_state = s_idle;   end

        // --- Word Space Sequence (7 cycles) ---
        s_word_1: begin parallel_out = 3'b100; next_state = s_word_2; end
        s_word_2: begin parallel_out = 3'b100; next_state = s_word_3; end
        s_word_3: begin parallel_out = 3'b100; next_state = s_word_4; end
        s_word_4: begin parallel_out = 3'b100; next_state = s_word_5; end
        s_word_5: begin parallel_out = 3'b100; next_state = s_word_6; end
        s_word_6: begin parallel_out = 3'b100; next_state = s_word_7; end
        s_word_7: begin parallel_out = 3'b100; next_state = s_idle;   end
        
        default:
        begin
            next_state = s_idle;
            parallel_out = 3'b000;
        end
    endcase
end

endmodule
