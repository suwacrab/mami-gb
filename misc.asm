SECTION "misccode",ROM0
time_add:
	LD HL,time
	LD A,[HL]
	INC A
	LDI [HL],A
	JR Z,.over
	RET
.over:
	; increment mem
	LD A,[HL]
	INC A
	LDI [HL],A
	RET
