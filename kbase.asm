; defs
KBSIZE EQU $0400
SECTION "kbase",ROM0

wait_vbl:
	HALT
	NOP
	RET

memcpy: ; copy bytes
	; DE = count
	; HL = dst
	; BC = src
.loop:
	; copy & increment
	LD A,[BC]
	LDI [HL],A
	INC BC
	; decrease count
	DEC DE
.check:
	LD A,E
	CP $00
	JR NZ,.loop
	LD A,D
	CP $00
	JR NZ,.loop
	RET

memset: ; set bytes
	; DE = count
	; HL = dst
	; B = byte to set with
.loop:
	LD A,B
	LDI [HL],A
	DEC DE
.check:
	LD A,E
	CP $00
	JR NZ,.loop
	LD A,D
	CP $00
	JR NZ,.loop
	RET

strcpy: ; copy string
	; HL = dst
	; BC = src
	PUSH HL
	PUSH BC
.loop:
	LD A,[BC]
	LDI [HL],A
	INC BC
	AND A
	JR NZ,.loop
	POP BC
	POP HL
	RET


