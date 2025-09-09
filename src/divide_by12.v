`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/15 14:44:40
// Design Name: 
// Module Name: divide_by12
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module divide_by12(
    	input wire [5:0] numerator,  // 입력 6비트 값 / 이 값을 12로 나누는 연산
    	output reg [2:0] quotient,  //몫(옥타브 정보로, 음의 높낮이를 결정)
    	output wire [3:0] remainder  //나머지(노트 정보)
    );
    
    reg [1:0] remainder3to2;
    
    always @(numerator[5:2])
    case(numerator[5:2])
    	 0: begin quotient=0; remainder3to2=0; end
    	 1: begin quotient=0; remainder3to2=1; end
    	 2: begin quotient=0; remainder3to2=2; end
    	 3: begin quotient=1; remainder3to2=0; end
    	 4: begin quotient=1; remainder3to2=1; end
    	 5: begin quotient=1; remainder3to2=2; end
    	 6: begin quotient=2; remainder3to2=0; end
    	 7: begin quotient=2; remainder3to2=1; end
    	 8: begin quotient=2; remainder3to2=2; end
    	 9: begin quotient=3; remainder3to2=0; end
    	10: begin quotient=3; remainder3to2=1; end
    	11: begin quotient=3; remainder3to2=2; end
    	12: begin quotient=4; remainder3to2=0; end
    	13: begin quotient=4; remainder3to2=1; end
    	14: begin quotient=4; remainder3to2=2; end
    	15: begin quotient=5; remainder3to2=0; end
    endcase
    
    assign remainder[1:0] = numerator[1:0];  // the first 2 bits are copied through
    assign remainder[3:2] = remainder3to2;  // and the last 2 bits come from the case statement
    
endmodule




