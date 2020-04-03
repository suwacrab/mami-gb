SECTION "mami_code",ROM0
mami_updt:
	;CALL joyp_check
	;CALL spr_test
	RET
joyp_check:
	; enable buttons
	LD A,P1F_GET_BTN
	LD [rP1],A
	; reset a & b
	LD A,$00
	LD [joyA],A
	LD [joyB],A
	; get button A & B
	LD HL,joyA
	; if A is pressed, go
	LD A,[rP1]
	AND A,P1F_0
	CALL Z,.setA
	INC HL
	; if B is pressed, go
	LD A,[rP1]
	AND A,P1F_1
	CALL Z,.setB
	RET
.setA:
	LD A,$01
	LD [HL],A
	RET
.setB:
	LD A,$01
	LD [HL],A
	RET

spr_test:
	; set x & y to 16
	LD HL,oam_shadow
	LD E,$00
.loop:
	; set Y to time
	PUSH HL
	LD HL,time
	LD A,$10
	ADD A,[HL]
	POP HL
	LDI [HL],A ; Y
	; set X to time
	PUSH HL
	LD HL,time
	LD A,$18
	ADD A,[HL]
	POP HL
	LDI [HL],A ; X
	; set tile to 128
	LD A,$80
	LDI [HL],A
	LD A,$80 | $01
	LDI [HL],A
	; increment E, check
	INC E
	LD A,E
	CP $04
	JR NZ,.loop
.end:
	CALL copy_oam
	RET

