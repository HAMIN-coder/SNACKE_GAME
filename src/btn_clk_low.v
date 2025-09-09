module btn_clk_fast (
    input wire clk, reset, 
    output reg update_clk
);

    reg [26:0] check;  // �� ū ī���� �� (100 MHz���� 1 Hz�� ����)

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            update_clk <= 0;
            check <= 0;
        end else if (check < 25000000) begin // 100 MHz / 1 Hz = 100,000,000
            check <= check + 1;
            update_clk <= 0; // �ֱⰡ �� �� �Ǹ� ��� 0
        end else begin
            check <= 0; // ī���� ����
            update_clk <= 1; // update_clk ��ȣ �߻�
        end
    end

endmodule
