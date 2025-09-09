
module music_i (
	input wire clk,i_speaker,o_speaker,
	output reg speaker
    );
    
    reg [30:0] tone;
    wire [7:0] fullnote_1,fullnote_2;
    reg [7:0] fullnote;
    wire [2:0] octave;
    wire [3:0] note ;
    reg [8:0] clkdivider;
    reg [8:0] counter_note;
    reg [7:0] counter_octave;   
    //음악주소 생성  
    always @(posedge clk)
        tone <= tone+31'd1;
     //음악 저장
     music_ROM_1 G1(.clk(clk), .address(tone[29:22]), .note(fullnote_1)); // 이겼을 때(루돌프 사슴코)
     music_ROM_2 G2(.clk(clk), .address(tone[29:22]), .note(fullnote_2)); // 졌을 때 (울면 안돼)
    //신호의 따른 선택
     always @* begin
     if (i_speaker) 
            fullnote = fullnote_1; // i_speaker -> ROM_1
        else if (o_speaker)
            fullnote = fullnote_2; // o_speaker -> ROM_2 
        else
            fullnote = 8'd0; 
    end
    //옥타브 음표 분리
    divide_by12 G3(.numerator(fullnote[5:0]), .quotient(octave), .remainder(note));
    
   //클럭 분주기 설정
    always @*
    case(note)
    	 0: clkdivider = 9'd511;//A
    	 1: clkdivider = 9'd482;// A#/Bb
    	 2: clkdivider = 9'd455;//B
    	 3: clkdivider = 9'd430;//C
    	 4: clkdivider = 9'd405;// C#/Db
    	 5: clkdivider = 9'd383;//D
    	 6: clkdivider = 9'd361;// D#/Eb
    	 7: clkdivider = 9'd341;//E
    	 8: clkdivider = 9'd322;//F
    	 9: clkdivider = 9'd303;// F#/Gb
    	10: clkdivider = 9'd286;//G
    	11: clkdivider = 9'd270;// G#/Ab
    	default: clkdivider = 9'd0;
    endcase
   //주파수 생성
    always @(posedge clk) counter_note <= counter_note==0 ? clkdivider : counter_note-9'd1;
    always @(posedge clk) if(counter_note==0) counter_octave <= counter_octave==0 ? 8'd255 >> octave : counter_octave-8'd1;
   // 스피커 출력 (PWM 신호 생성)
    always @(posedge clk) 
        if (counter_note == 0 && counter_octave == 0 && fullnote != 0 && tone[21:18] != 0)
            speaker <= ~speaker;
    endmodule