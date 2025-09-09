module btn_clk (
    input wire clk, reset, 
    output reg update_clk
);

    reg [26:0] check;  // �� ū ī���� �� 

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            update_clk <= 0;
            check <= 0;
        end else if (check < 50000000) begin 
            check <= check + 1;
            update_clk <= 0; // �ֱⰡ �� �� �Ǹ� ��� 0
        end else begin
            check <= 0; // ī���� ����
            update_clk <= 1; // update_clk ��ȣ �߻�
        end
    end

endmodule
