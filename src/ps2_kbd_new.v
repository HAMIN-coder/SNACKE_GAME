`default_nettype none

`define TIMER_120U_BIT_SIZE 13
`define FRAME_BIT_NUM 11

`define ready_st 'b0
`define ready_ack_st 'b1

`define RELEASE_CODE   'b11110000   // F0
`define EXTENDED_CODE 'b11100000    // E0
`define TIMER_120U_TERMINAL_VAL 6000

module ps2_kbd_new(
    input wire clk,
    input wire rst,
    input wire ps2_clk,
    input wire ps2_data,
   input wire read,
    output reg [7:0] scancode,
    output wire data_ready,
    output reg released,
    output reg err_ind,
    output reg right,left,up,down
    );
    
localparam S_H = 2'b00, S_L = 2'b01, S_L2H = 2'b11, S_H2L = 2'b10;

reg [1:0] st,nx_st;
reg [1:0] nx_st2,st2;

reg ps2_clk_d, ps2_clk_s, ps2_data_d, ps2_data_s;
wire ps2_clk_rising_edge, ps2_clk_falling_edge;
wire rst_timer, shift_done;
reg [`FRAME_BIT_NUM - 1 : 0] q;
wire shift;
reg [3:0] bit_cnt;
wire reset_bit_cnt;
wire timer_timeout;
reg [`TIMER_120U_BIT_SIZE-1:0] timer_cnt;
wire got_release;
wire output_strobe;
reg hold_release;
wire extended;
reg hold_extended;
wire err;
reg parity_err,ss_bits_err;
reg p;
reg valid;
reg shift_flag;

//PS/2 Ŭ�� �� ������ ����ȭ
always  @(posedge rst,posedge clk) 
begin : sync_reg
   if(rst == 'b1)
      begin
         ps2_clk_d <= 'b1;
         ps2_data_d <= 'b1;
         ps2_clk_s<= 'b1;
         ps2_data_s <= 'b1;
      end
   else
      begin
         ps2_clk_d <= ps2_clk;
         ps2_data_d <= ps2_data;
         ps2_clk_s <= ps2_clk_d;
         ps2_data_s <= ps2_data_d;
      end
   end

//��������:��� �ϰ� ���� ����
assign ps2_clk_rising_edge = !ps2_clk_s & ps2_clk_d;
assign ps2_clk_falling_edge = !ps2_clk_d & ps2_clk_s;

//FSM
always @(posedge clk) 
   begin : state_reg
      if(rst == 'b1)
         st <= S_H;
      else
         st <= nx_st;
   end
   
always @(*)
   begin
      (* FULL_CASE, PARALLEL_CASE *)
      case (st) 
         S_L : nx_st = (ps2_clk_rising_edge == 'b1) ? S_L2H : S_L;
         S_L2H : nx_st = S_H;
         S_H : nx_st = (ps2_clk_falling_edge == 'b1) ? S_H2L : S_H;
         S_H2L : nx_st = S_L;
         default : nx_st = S_H;                  
      endcase
   end

// output signals for the state machine
assign shift = (st == S_H2L) ? 'b1 : 'b0;
assign rst_timer = (st == S_H2L || st == S_L2H ) ? 'b1 : 'b0;

// bit counter
always @(posedge clk)
   begin : cnt_bit_num 
      if((rst == 'b1) || (shift_done == 'b1))
         bit_cnt <= 4'b0;
      else if(reset_bit_cnt == 'b1) 
         bit_cnt <= 4'b0;
      else if(shift == 'b1)
         bit_cnt <= bit_cnt + 'b1;
   end 

assign timer_timeout = (timer_cnt == `TIMER_120U_TERMINAL_VAL) ? 'b1 : 'b0;
assign reset_bit_cnt = (timer_timeout == 'b1 && st == S_H && ps2_clk_s == 'b1) ? 'b1 : 'b0;

// 120 us timer
always @(posedge clk)
   begin : timer 
      if(rst_timer == 'b1)
         timer_cnt <= 'b0;
      else if(timer_timeout == 'b0)
         timer_cnt <= timer_cnt + 'b1;   
   end

// shift register for SIPO operation (11-bit length)
// ps2clk   falling edge        ps2data      bit   shift ?  q(11bit: start_bit(1), data_bit(8), parity_bit(1), stop_bit(1))   ?   ?�� .
always @(posedge clk)
   begin : shift_R 
      if(rst == 'b1) 
         q <= 'b0;
      else if(shift == 'b1 ) 
         q <= { ps2_data_s, q[`FRAME_BIT_NUM-1 : 1] };
   end


assign shift_done = (bit_cnt == `FRAME_BIT_NUM) ? 'b1 : 'b0;

assign got_release = (q[8:1] == `RELEASE_CODE) && (shift_done == 'b1) ? 'b1 : 'b0;
assign extended = (q[8:1] == `EXTENDED_CODE) && (shift_done == 'b1) ? 'b1 : 'b0;

assign output_strobe = ((shift_done == 'b1) && (got_release == 'b0) && (extended == 'b0)) ? 'b1 : 'b0;

always @(posedge clk)
   begin : latch_released 
      if( rst == 'b1 || output_strobe == 'b1)
         hold_release <= 'b0;
      else if(got_release == 'b1)
         hold_release <= 'b1;
   end
   
always @(posedge clk)
   begin : latch_extended
      if( rst == 'b1 || output_strobe == 'b1)
         hold_extended <= 'b0;
      else if(extended == 'b1)
         hold_extended <= 'b1;
   end


always  @(posedge clk)
   begin : comm_state_reg
      if(rst == 'b1) 
         st2 <= `ready_ack_st;
      else
         st2 <= nx_st2;
   end 
   
always @(st2, output_strobe, read)
   begin 
      (* FULL_CASE, PARALLEL_CASE *)
      case (st2) 
         `ready_ack_st : 
            nx_st2 = (output_strobe == 'b1) ? `ready_st : `ready_ack_st;
         `ready_st :
            nx_st2 = (read == 'b1) ?  `ready_ack_st : `ready_st;
         default : 
            nx_st2 = `ready_ack_st;                  
      endcase
   end
   
assign data_ready = (st2 == `ready_st) ? 'b1 : 'b0;
////////////////
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset ���¿��� �ʱ�ȭ
        scancode <= 8'b0;
        shift_flag <= 1'b0;
        released <= 1'b1;
        err_ind <= 1'b0;
        right <= 1'b0; // ����Ű �ʱ�ȭ
        left <= 1'b0;  // ����Ű �ʱ�ȭ
        up <= 1'b0;    // ����Ű �ʱ�ȭ
        down <= 1'b0;  // ����Ű �ʱ�ȭ
    end else if (output_strobe == 1'b1) begin
        // Ű���� �Է� ó��
        scancode <= q[8:1];
        released <= hold_release;
        err_ind <= err;

        // ����Ű �ʱ�ȭ
        right <= 1'b0;
        left <= 1'b0;
        up <= 1'b0;
        down <= 1'b0;

        if (hold_extended == 1'b1) begin
            // ����Ű �Է� ó��
            case (q[8:1])
                'h74: begin 
                    scancode <= 'h90; 
                    right <= 1'b1; // Right Arrow
                end 
                'h6B: begin 
                    scancode <= 'h91; 
                    left <= 1'b1;  // Left Arrow
                end 
                'h75: begin 
                    scancode <= 'h92; 
                    up <= 1'b1;    // Up Arrow
                end 
                'h72: begin 
                    scancode <= 'h93; 
                    down <= 1'b1;  // Down Arrow
                end 
                default: begin
                    scancode <= scancode; // �ٸ� �Է� ����
                end
            endcase
        end
    end else begin
        // ���� ����
        scancode <= scancode;
        err_ind <= err_ind;
        released <= released;
    end
end

always @(q)
   begin : err_chk 
      p = q[0] ^ q[1] ^ q[2] ^ q[3] ^ q[4] ^ q[5] ^ q[6] ^ q[7] ^ q[8] ^ q[9] ^ q[10];   
      parity_err = ( p == 'b1) ? 1'b0 : 1'b1;
      ss_bits_err = ( q[0] == 'b1 || q[10] == 'b0) ? 1'b1 : 1'b0;
   end
   
assign err = parity_err || ss_bits_err;

endmodule
