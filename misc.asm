SECTION "misccode",ROM0
add_time:
	; load regs
	LD HL,time
	INC [HL]
	RET
.over:
	RET
