; defs
KBSIZE EQU $0400
OAMSIZE EQU $4 * 40
wait_vbl:
	HALT
	NOP
	RETI

palcpy: ; copy bg palette
	; HL = source
	; A = index
	; DE = count ( in bytes! )
	LD B,(1<<7)
	ADD A,A ; multiply index by 2
	OR A,B ; set auto-increment
	LD [rBCPS],A
.cpy:
	LDI A,[HL]
	LD [rBCPD],A
	DEC DE
.check:
	LD A,E
	CP $00
	JR NZ,.cpy
	LD A,D
	CP $00
	JR NZ,.cpy
	RET

palcpy_obj: ; copy obj palette
	; HL = source
	; A = index
	; DE = count ( in bytes! )
	LD B,(1<<7)
	ADD A,A ; multiply index by 2
	OR A,B ; set auto-increment
	LD [rOCPS],A
.cpy:
	LDI A,[HL]
	LD [rOCPD],A
	DEC DE
.check:
	LD A,E
	CP $00
	JR NZ,.cpy
	LD A,D
	CP $00
	JR NZ,.cpy
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


