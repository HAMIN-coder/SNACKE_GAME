`default_nettype none

module Random(
    input wire clk,
    input wire reset,
    output reg [9:0] randX,
    output reg [8:0] randY
    );
    // LFSR based random generator for X and Y values
    reg [15:0] lfsrX = 16'hACE1;  // 초기값을 사용하여 LFSR 설정 (적절한 시드 값 사용)
    reg [15:0] lfsrY = 16'hC0DE;  // 초기값을 사용하여 LFSR 설정 (적절한 시드 값 사용)

    // X 좌표 생성: 10비트 랜덤값
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsrX <= 16'hACE1; // 리셋 시 초기 시드값으로 설정
        end else begin
            lfsrX <= {lfsrX[14:0], lfsrX[15] ^ lfsrX[13] ^ lfsrX[12] ^ lfsrX[10]}; // LFSR
        end
    end

    // Y 좌표 생성: 9비트 랜덤값
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsrY <= 16'hC0DE; // 리셋 시 초기 시드값으로 설정
        end else begin
            lfsrY <= {lfsrY[14:0], lfsrY[15] ^ lfsrY[13] ^ lfsrY[12] ^ lfsrY[10]}; // LFSR
        end
    end

    // randX, randY는 LFSR의 값을 기반으로 하여 10비트 X와 9비트 Y 값을 생성
    always @(posedge clk) begin
        randX <= (lfsrX[9:0] % 261) + 90;  // X 범위: 90~350
        randY <= (lfsrY[8:0] % 261) + 90;  // Y 범위: 90~350
    end
endmodule
