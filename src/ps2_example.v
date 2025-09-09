
module ps2_example(
      input   wire     clk,
      input   wire     rst,
      input   wire     ps2clk,
      input   wire     ps2data,
      output  wire     right,left,up,down
      );
      
      
    wire [7:0] scancode;//PS/2 키보드로부터 받은 스캔 코드 (8비트)
    wire err_ind;// 키보드 입력 처리 과정에서 발생한 에러를 나타내는 신호
    wire clk_50;
    wire clk_100;

    //clock generator
    clk_wiz_0 U1( .clk_out1(clk_100),.clk_out2(),.clk_out3(clk_50),.clk_out4(),.reset(rst),.locked(),.clk_in1(clk));
    //output reg right,left,up,down
    // PS/2 키보드 입력 처리    
    ps2_kbd_top ps2_kbd (
        .clk(clk_50), 
        .rst(rst), 
        .ps2clk(ps2clk), 
        .ps2data(ps2data), 
        .scancode(scancode), 
        .Released(), 
        .err_ind(err_ind),
        .right(right),
        .left(left),
        .up(up),
        .down(down)
        );
   
endmodule