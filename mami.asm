SECTION "mami_code",ROM0
mami_updt:
	CALL joyp_check
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
