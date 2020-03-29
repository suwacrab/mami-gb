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
	DW .txt0
	DW .txt1
.txt0:
	DB "oh! create!",0
.txt1:
	DB "ah? remove?",0

testfont:
	INCBIN "gfx/font.chr"
testfont_end:

; main code
SECTION "main",ROM0
start:
	CALL .init_sys
	CALL .init_fnt
	JP main_loop

.init_fnt:
	; copy char to vram
	LD BC,testfont
	LD HL,_VRAM
	LD DE,($10 * $80) ; 28 tiles
	CALL memcpy
	; copy text to vram
	LD BC,testtxt.txt0
	LD HL,_SCRN0
	CALL strcpy
	; copy to wram
	LD HL,_RAM
	LD BC,testtxt.txt1
	CALL strcpy
	; turn on lcd
	LD A, LCDCF_ON | LCDCF_BGON | LCDCF_BG8000
	LD [rLCDC],A
	RET

.init_sys:
	; turn off LCD
	LD A,[rLY]
	CP 144
	JR C,.init_sys ; wait for end of VBlank...
	LD A, LCDCF_OFF
	ld [rLCDC],A
	; palette reset
	LD A,%11100100
	LD [rBGP],A
	LD [rOBP0],A
	LD [rOBP1],A
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
	LD HL,_VRAM
	LD DE,$2000
	LD B,$00
	CALL memset
	RET

main_loop:
	; do bullshit
	
	; wait
	jr main_loop

