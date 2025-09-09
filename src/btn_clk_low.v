module btn_clk_fast (
    input wire clk, reset, 
    output reg update_clk
);

    reg [26:0] check;  // 더 큰 카운터 값 (100 MHz에서 1 Hz로 설정)

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            update_clk <= 0;
            check <= 0;
        end else if (check < 25000000) begin // 100 MHz / 1 Hz = 100,000,000
            check <= check + 1;
            update_clk <= 0; // 주기가 다 안 되면 계속 0
        end else begin
            check <= 0; // 카운터 리셋
            update_clk <= 1; // update_clk 신호 발생
        end
    end

endmodule
