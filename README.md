# SNACKE_GAME

## 프로젝트 개요
본 프로젝트는 FPGA(Nexys 7 보드, Vivado 환경)를 활용하여 VGA 화면에 동작하는 SNAKE GAME을 구현한 과제이다. 
플레이어는 키보드 방향키로 갈색 네모(루돌프)를 조작하여 선물을 수집하며, 최대 6개를 모으면 승리한다.

## 주요 특징
- VGA 출력 기반 게임 화면
- PS/2 키보드 입력
- 선물 랜덤 생성(LFSR 기반)
- 점수(7-Segment) 및 LED 상태 표시
- RGB LED로 상태(진행/승리/패배)표시
- 승리/ 패배 시 음악 재생 스피커 출력

## 입출력 구성
입력
- 키보드(방향키): 루돌프 이동
- 스위치: 난이도 조절(Easy/Hard)
- 버튼:게임 Reset

출력
- VGA:게임 화면 표시
- 7-Segment: 현재 점수
- LED: 남은 선물 개수
- RGB LED: 게임 상태 표시 (초록=진행, 빨강=승리, 파랑=패배)
- 스피커: 승리/패배 음악 재생 (승리: 루덜프 사슴코 음악 실행 / 실패: 울면 안돼 음악 실행)
  
## Top-module
<img width="928" height="652" alt="image" src="https://github.com/user-attachments/assets/1098703f-e265-4fad-90fd-02fce407791c" />

- control_unit.v: FSM 기반 게임 상태 제어
- snake.v: 루돌프/선물/충돌 처리 및 VGA 출력
- random.v: LFSR 기반 좌표 랜덤 생성
- ps2_kbd_top.v: 키보드 입력 처리
- music_i.v: 게임 결과 음악 재생
- score.v, led.v, rgb.v: 점수/LED/RGB 출력

## FSM
<img width="783" height="389" alt="image" src="https://github.com/user-attachments/assets/e8d40ed8-f7b0-4389-85e2-3bec7555c0c7" />

## 게임 화면 및 조작 방법
1. 게임 시작 초기 화면
<img width="691" height="257" alt="image" src="https://github.com/user-attachments/assets/ae33249c-9f19-4195-bd8b-1a3a197aae0d" />

게임이 시작되면 화면에 루돌프가 처음 위치에 있고 선물이 랜덤으로 배정되
어 있는 것을 확인할 수 있다. FPGA보드를 보면 아무 상자를 얻지 못해서 
segment에는 0, led는 6개 모두 켜져 있는 것을 확인할 수 있다. 또한 초록빛
을 통해 게임이 끝나지 않았음을 시각적으로 확인할 수 있다. 여기서 SW0가 0
이면 hard mode, 1이면 easy mode로 게임 난이도를 정할 수 있다. Mode를 정
했다면 키보드의 방향키를 눌러 테두리를 피해 루돌프를 움직이면 된다.

2. 게임 진행 중
<img width="712" height="263" alt="image" src="https://github.com/user-attachments/assets/efb4e395-cc05-4f36-a3fc-9119ebc08c49" />

루돌프가 랜덤으로 배치된 선물을 얻으면 뒤에 선물이 따라온다. (=snake 몸 
길이 증가) 얻은 선물의 색깔 대로 뒤에 똑같은 색깔로 따라오는 것을 확인할 
수 있다. FPGA 보드를 보면 선물을 네 개 먹었기 때문에 segment에 4가 나타
나고 남은 선물 숫자인 2개의 led와 게임이 진행중이라는 초록 빛을 확인할 
수 있다. 

3. 게임 종료 (gameover이 되었을 때)
<img width="733" height="274" alt="image" src="https://github.com/user-attachments/assets/32ee70bb-73a4-4ede-8f73-460b447b2344" />

루돌프가 뒤에 따라오던 선물이나 테두리에 부딪혔을 때는 gameover이다. 화
면에 보이듯이 테두리는 남아있고 검은 화면이 뜬다. FPGA보드에는 이전까지 
얻었던 점수와 못 먹은 선물의 개수(led) 그리고 빨간색 불빛으로 gameover가 
되었음을 시각적으로 확인할 수 있다. 

4.  게임임 종료 (win일 때)
<img width="739" height="277" alt="image" src="https://github.com/user-attachments/assets/0ca74dd3-48f4-40fa-bbdd-3698d353ebfc" />

루돌프가 선물을 6개 모두 모았을 때는 화면에 선물 그림이 나타나는 것을 확
인할 수 있다. FPGA보드를 보면 선물 6개를 모두 모았기 때문에 segment에는 
6이 떠있고 남은 선물의 개수는 없기 때문에 led는 모두 꺼져 있다. 마지막으
로 빨간 불빛으로 게임을 이겼다는 것을 시각적으로 확인할 수 있다.
