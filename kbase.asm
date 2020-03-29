; defs
KBSIZE EQU $0400
SECTION "kbase",ROM0
memcpy:
	; DE = size
	; HL = dst
	; BC = src
.loop:
	LD A,[BC]
	LD [BC],A
