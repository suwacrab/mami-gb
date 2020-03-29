INCLUDE "hardware.inc"
INCLUDE "kbase.asm"
INCLUDE "suwako.asm"
INCLUDE "suwa_obj.asm"

; entrypoint
SECTION "header",ROM0[$0100]
entrypoint:
	DI
	JP start

; data
SECTION "data",ROM0[$0150]
testtxt:
	DW .testtxt_0
	DW .testtxt_1
.testtxt_0:
	DB "oh! create!",0
.testtxt_1:
	DB "ah? remove?",0

testfont:
	INCBIN "gfx/font.chr"

; main code
SECTION "main",ROM0
start:
	CALL .init_sys
	jp main_loop

.init_sys:
	; turn off LCD
	LD A,[rLY]
	CP 144
	JR C,.init_sys ; wait for end of VBlank...
	xor a
	ld [rLCDC],A
	; palette reset
	LD A,%11100100
	LD [rBGP],A
	LD [rOBP0],A
	LD [rOBP1],A
	; initialize misc memory
	CALL .init_wram
	CALL .init_oam
	; enable LCD again
	RET
.init_wram:
	LD HL,_RAM
	LD DE,$0000
.init_wram_loop:
	; load mem & increment
	LD A,$00
	LD [HL+],A
	INC DE
	; compare hi
	LD A,D
	CP A,$20
	JR C,.init_wram_loop
	RET
.init_oam:
	RET
	

main_loop:
	LD HL,_RAM
	INC [HL]
	jr main_loop
