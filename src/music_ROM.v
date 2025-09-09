`define A1 8'd21
`define C 8'd24
`define D 8'd26
`define E 8'd28
`define F 8'd29
`define G 8'd31
`define A 8'd33
`define B 8'd35
`define C2 8'd36
`define D2 8'd38
`define F2 8'd41
`define G2 8'd43

module music_ROM_2(
    input wire clk,
    input wire [7:0] address,
    output reg [7:0] note
);

    always @(posedge clk)
    case(address)
 0: note <=  `E;  
 1: note <=  `F;  
 2: note <=  `G;  
 3: note <=  `G;  
 4: note <=  `G;  
 5: note <=  `G;  
 6: ;             
 7: ;             
 8: note <=  `A; 
 9: note <=  `B; 
10: note <=  `B; 
11: note <=  `C2;
12: note <=  `C2;
13: note <=  `C2;
14: note <=  `C2;
15: ;            
16: ;                  
17: note <=  `E; 
18: note <=  `F; 
19: note <=  `G; 
20: note <=  `G; 
21: note <=  `G; 
22: note <=  `G; 
23: note <=  `G; 
24: note <=  `G; 
25: note <=  `A; 
26: note <=  `G; 
27: note <=  `F; 
28: note <=  `F; 
29: note <=  `F; 
30: note <=  `F; 
31: note <=  `F; 
32: note <=  `F; 
33: note <=  `F;  
34: note <= `E;  
35: note <= `E;  
36: note <= `G;  
37: note <= `G;  
38: note <= `C;  
39: note <= `C;  
40: note <= `E;  
41: note <= `E;          
42: note <= `D;  
43: note <= `D;  
44: note <= `F;  
45: note <= `F;  
46: note <= `F;  
47: note <= `F;  
48: note <= `A1; 
49: note <= `A1; 
50: note <=  `C;  
51: note <=  `C;  
52: note <=  `C;  
53: note <=  `C;  
54: note <=  `C;  
55: note <=  `C;  

56: note <=  `E;   
57: note <=  `F;   
58: note <=  `G;   
59: note <=  `G;   
60: note <=  `G;   
61: note <=  `G;   
62: ;              
63: ;              
64: note <=  `A;   
65: note <=  `B;   
66: note <=  `B;   
67: note <=  `C2;  
69: note <=  `C2;  
70: note <=  `C2;  
71: note <=  `C2;  
72: ;              
73: ;              
74: note <=  `E;   
75: note <=  `F;   
76: note <=  `G;   
77: note <=  `G;   
78: note <=  `G;   
79: note <=  `G;   
80: note <=  `G;   
81: note <=  `G;   
82: note <=  `A;   
83: note <=  `G;   
84: note <=  `F;   
85: note <=  `F;   
86: note <=  `F;   
87: note <=  `F;   
88: note <=  `F;   
89: note <=  `F;   
90: note <=  `F;   
91: note <= `E;    
92: note <= `E;    
93: note <= `G;    
94: note <= `G;    
95: note <= `C;    
96: note <= `C;    
97: note <= `E;    
98: note <= `E;    
99: note <= `D;    
100: note <= `D;      
101: note <= `F;      
102: note <= `F;      
103: note <= `F;      
104: note <= `F;      
105: note <= `A1;     
106: note <= `A1;     
107: note <=  `C;     
108: note <=  `C;     
109: note <=  `C;     
110: note <=  `C;    
111: note <=  `C;    
  
112:  note <=  `E;   
113:  note <=  `F;   
114:  note <=  `G;   
115:  note <=  `G;   
116:  note <=  `G;   
117:  note <=  `G;   
118:  ;              
119:  ;              
120:  note <=  `A;   
121:  note <=  `B;   
122:  note <=  `B;   
123:  note <=  `C2;  
124:  note <=  `C2;  
125:  note <=  `C2;  
126:  note <=  `C2;  
127:  ;              
128:  ;              
129:  note <=  `E;   
130:  note <=  `F;   
131:  note <=  `G;   
132:  note <=  `G;   
133:  note <=  `G;   
134:  note <=  `G;   
135:  note <=  `G;   
136:  note <=  `G;   
137:  note <=  `A;   
138:  note <=  `G;   
139:  note <=  `F;   
140:  note <=  `F;   
141:  note <=  `F;   
142:  note <=  `F;   
143:  note <=  `F;   
144:  note <=  `F;   
145:  note <=  `F;   
146:  note <= `E;    
147:  note <= `E;    
148:  note <= `G;    
149:  note <= `G;    
150:  note <= `C;    
151:  note <= `C;    
152:  note <= `E;    
153:  note <= `E;    
154:  note <= `D;    
155:  note <= `D;    
156:  note <= `F;    
157:  note <= `F;    
158:  note <= `F;    
159:  note <= `F;    
160:  note <= `A1;   
161:  note <= `A1;   
162:  note <=  `C;   
163:  note <=  `C;   
164:  note <=  `C;   
165:  note <=  `C;   
166:  note <=  `C;   
167:  note <=  `C;   
  
168:  note <=  `E;   
169:  note <=  `F;   
170:  note <=  `G;   
171:  note <=  `G;   
172:  note <=  `G;   
173:  note <=  `G;   
174:  ;              
175:  ;              
176:  note <=  `A;   
177:  note <=  `B;   
178:  note <=  `B;   
179:  note <=  `C2;  
180:  note <=  `C2;  
181:  note <=  `C2;  
182:  note <=  `C2;  
183:  ;              
184:  ;              
185:  note <=  `E;   
186:  note <=  `F;   
187:  note <=  `G;   
188:  note <=  `G;   
189:  note <=  `G;   
190:  note <=  `G;   
191:  note <=  `G;   
192:  note <=  `G;   
193:  note <=  `A;   
194:  note <=  `G;   
195:  note <=  `F;   
196:  note <=  `F;   
197:  note <=  `F;   
198:  note <=  `F;   
199:  note <=  `F;   
200:  note <=  `F;   
201:  note <=  `F;   
202:  note <= `E;    
203:  note <= `E;    
204:  note <= `G;    
205:  note <= `G;    
206:  note <= `C;    
207:  note <= `C;    
208:  note <= `E;    
209:  note <= `E;    
209:  note <= `D;                     
210:  note <= `D;    
211:  note <= `F;    
212:  note <= `F;    
213:  note <= `F;    
214:  note <= `F;    
215:  note <= `A1;   
216:  note <= `A1;   
217:  note <=  `C;   
218:  note <=  `C;   
219:  note <=  `C;   
220:  note <=  `C;   
221:  note <=  `C;   
222:  note <=  `C;   
223:  note <=  `C;   
  
224: note <=  `E;    
225: note <=  `F;    
226: note <=  `G;    
227: note <=  `G;    
228: note <=  `G;    
229: note <=  `G;    
230: ;               
231: ;               
232: note <=  `A;    
233: note <=  `B;    
234: note <=  `B;    
235: note <=  `C2;   
236: note <=  `C2;   
237: note <=  `C2;   
238: note <=  `C2;   
239: ;               
240: ;               
241: note <=  `E;    
242: note <=  `F;   
242: note <=  `G;   
242: note <=  `G;   
242: note <=  `G;   
242: note <=  `G;   
242: note <=  `G;   
242: note <=  `G;   
242: note <=  `A;   
242: note <=  `G;   
              
         default: note <= 8'd0; // Rest
      endcase
endmodule
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
