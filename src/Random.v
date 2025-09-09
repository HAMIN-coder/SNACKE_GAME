`default_nettype none

module Random(
    input wire clk,
    input wire reset,
    output reg [9:0] randX,
    output reg [8:0] randY
    );
    // LFSR based random generator for X and Y values
    reg [15:0] lfsrX = 16'hACE1;  // �ʱⰪ�� ����Ͽ� LFSR ���� (������ �õ� �� ���)
    reg [15:0] lfsrY = 16'hC0DE;  // �ʱⰪ�� ����Ͽ� LFSR ���� (������ �õ� �� ���)

    // X ��ǥ ����: 10��Ʈ ������
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsrX <= 16'hACE1; // ���� �� �ʱ� �õ尪���� ����
        end else begin
            lfsrX <= {lfsrX[14:0], lfsrX[15] ^ lfsrX[13] ^ lfsrX[12] ^ lfsrX[10]}; // LFSR
        end
    end

    // Y ��ǥ ����: 9��Ʈ ������
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsrY <= 16'hC0DE; // ���� �� �ʱ� �õ尪���� ����
        end else begin
            lfsrY <= {lfsrY[14:0], lfsrY[15] ^ lfsrY[13] ^ lfsrY[12] ^ lfsrY[10]}; // LFSR
        end
    end

    // randX, randY�� LFSR�� ���� ������� �Ͽ� 10��Ʈ X�� 9��Ʈ Y ���� ����
    always @(posedge clk) begin
        randX <= (lfsrX[9:0] % 261) + 90;  // X ����: 90~350
        randY <= (lfsrY[8:0] % 261) + 90;  // Y ����: 90~350
    end
endmodule
