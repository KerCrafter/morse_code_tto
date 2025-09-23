module rec_fsm(clk,p_in,rst,s_out);

input rst;
input clk;
input [1:0]p_in;

output reg [7:0]s_out;

reg [7:0] state;
reg [7:0] next_state;

parameter [7:0]reset_state = 8'hff;
parameter [7:0]a = 8'h00;
parameter [7:0]b = 8'h01;
parameter [7:0]c = 8'h02;
parameter [7:0]d = 8'h03;
parameter [7:0]e = 8'h04;
parameter [7:0]f = 8'h05;
parameter [7:0]g = 8'h06;
parameter [7:0]h = 8'h07;
parameter [7:0]i = 8'h08;
parameter [7:0]j = 8'h09;
parameter [7:0]k = 8'h0a;
parameter [7:0]l = 8'h0b;
parameter [7:0]m = 8'h0c;
parameter [7:0]n = 8'h0d;
parameter [7:0]o = 8'h0e;
parameter [7:0]p = 8'h0f;
parameter [7:0]q = 8'h10;
parameter [7:0]r = 8'h11;
parameter [7:0]s = 8'h12;
parameter [7:0]t = 8'h13;
parameter [7:0]u = 8'h14;
parameter [7:0]v = 8'h15;
parameter [7:0]w = 8'h16;
parameter [7:0]x = 8'h17;
parameter [7:0]y = 8'h18;
parameter [7:0]z = 8'h19;

parameter [7:0]zero = 8'h20;
parameter [7:0]one = 8'h21;
parameter [7:0]two = 8'h22;
parameter [7:0]three = 8'h23;
parameter [7:0]four = 8'h24;
parameter [7:0]five = 8'h25;
parameter [7:0]six = 8'h26;
parameter [7:0]seven = 8'h27;
parameter [7:0]eight = 8'h28;
parameter [7:0]nine = 8'h29;

parameter [7:0]ds1 = 8'h2a;
parameter [7:0]ds2 = 8'h2b;
parameter [7:0]ds3 = 8'h2c;

always @(posedge clk or negedge rst) begin
if(!rst)
state <= reset_state;
else
state <= next_state;
end


always @(*) begin
    case(state)

        reset_state: //for reset state
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = e;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = t;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hff;
            end
        endcase

        a: //for a
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = r;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = w;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h88;
            end
        endcase

        b: //for b
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = six;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h83;
            end
        endcase

        c: //for c
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hc6;
            end
        endcase

        d: //for d
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = b;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = x;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'ha1;
            end
        endcase

        e: //for e
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = i;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = a;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h86;
            end
        endcase

        f: //for f
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h8e;
            end
        endcase

        g: //for g
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = z;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = q;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hc2;
            end
        endcase

        h: //for h
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = five;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = four;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h89;
            end
        endcase

        i: //for i
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = s;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = u;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hcf;
            end
        endcase

        j: //for j
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = one;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'he1;
            end
        endcase

        k: //for k
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = c;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = y;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h8a;
            end
        endcase

        l: //for l
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hc7;
            end
        endcase

        m: //for m
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = g;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = o;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'haa;
            end
        endcase
        n: //for n
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = d;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = k;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hab;
            end
        endcase

        o: //for o
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = ds1;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hc0;
            end
        endcase

        p: //for p
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h8c;
            end
        endcase

        q: //for q
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h98;
            end
        endcase

        r: //for r
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = l;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h9e;
            end
        endcase

        s: //for s
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = h;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = v;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h92;
            end
        endcase

        t: //for t
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = n;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = m;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h87;
            end
        endcase

        u: //for u
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = f;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = ds3;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hc1;
            end
        endcase

        v: //for v
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = three;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'he3;
            end
        endcase

        w: //for w
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = p;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = j;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hd5;
            end
        endcase

        x: //for x
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h89;
            end
        endcase

        y: //for y
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h91;
            end
        endcase

        z: //for z
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = seven;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'ha4;
            end
        endcase

        one: //for 1
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hf9;
            end
        endcase

        two: //for 2
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'ha4;
            end
        endcase

        three: //for 3
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hb0;
            end
        endcase

        four: //for 4
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h99;
            end
        endcase

        five: //for 5
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h92;
            end
        endcase

        six: //for 6
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h82;
            end
        endcase

        seven: //for 7
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hf8;
            end
        endcase

        eight: //for 8
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h80;
            end
        endcase

        nine: //for 9
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'h90;
            end
        endcase

        zero: //for 0
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hc0;
            end
        endcase

        ds1: //for ds1
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = eight;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hff;
            end
        endcase

        ds2: //for ds2
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = nine;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = zero;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hff;
            end
        endcase

        ds3: //for ds3
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = two;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hff;
            end
        endcase

        default: //for default
        case(p_in)
            2'b00:begin
                next_state = state;
                s_out = 8'hff;
            end

            2'b01:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b10:begin
                next_state = reset_state;
                s_out = 8'hff;
            end

            2'b11:begin
                next_state = reset_state;
                s_out = 8'hff;
            end
        endcase

    endcase
end

//end
endmodule
