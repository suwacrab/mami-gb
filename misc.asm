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

main_init:
	; enable interrupts
	EI
	LD A,IEF_VBLANK
	LD [rIE],A
	; reset stack
	LD SP,$FFFF
	; init & jump to main
	PUSH AF
	PUSH BC
	PUSH DE
	PUSH HL
	CALL .init_sys
	CALL .init_fnt
	POP HL
	POP DE
	POP BC
	POP AF
	JP main_loop

.init_fnt:
	; copy char to vram
	LD BC,testfont
	LD HL,_VRAM
	LD DE,($10 * $80) ; 28 tiles
	CALL memcpy
	; copy text to vram
	LD BC,testtxt.txt1
	LD HL,_SCRN0
	CALL strcpy
	; turn on lcd
	LD A, LCDCF_ON | LCDCF_BGON | LCDCF_BG8000
	LD [rLCDC],A
	RET

.init_sys:
	; turn off LCD
	CALL wait_vbl
	XOR A
	LD [rLCDC],A
	; palette reset
	LD A,%11100100
	LD [rBGP],A
	LD [rOBP0],A
	LD [rOBP1],A
	; palette copy
	; ; copy emptypal
	LD DE,$0040 * 2 ; 64 colors
	LD HL,palettes.emptypal
	LD A,$00
	CALL palcpy
	; ; copy testpal
	LD DE,$0004 * 2 ; 4 colors
	LD HL,palettes.testpal0
	LD A,$04 ; 0th index
	CALL palcpy
	; ; copy creampal
	LD HL,palettes.creampal
	LD DE,$0004 * 2
	LD A,$00 ; 0th index
	CALL palcpy ; copy creampal
	; initialize misc memory
	CALL .init_ram
	RET
.init_ram:
	; WRAM clear
	LD HL,_RAM
	LD DE,$2000
	LD B,$FF
	CALL memset
	; VRAM clear
	LD HL,_SCRN0
	LD DE,$400
	LD B,$00
	CALL memset
	RET

