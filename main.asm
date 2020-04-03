INCLUDE "hardware.inc"
INCLUDE "kbase.asm"
INCLUDE "misc.asm"
INCLUDE "suwako.asm"
INCLUDE "suwa_obj.asm"

; entrypoint
SECTION "header",ROM0[$0100]
entrypoint:
	DI
	JP start

SECTION "vblank",ROM0[$0040]
int_vblank:
	RETI

; data
SECTION "data",ROM0[$0150]
testtxt:
	DW .txt0
	DW .txt1
.txt0: DB "oh! create!",0
.txt1: DB "ah? remove?",0

testfont:
	INCBIN "gfx/font.chr"
testfont_end:

; main code
SECTION "main",ROM0
start:
	EI
	LD A,IEF_VBLANK
	LD [rIE],A
	LD SP,$FFFF
.loop:
	LD HL,time
	INC [HL]
	CALL wait_vbl
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

main_loop:
	; turn off LCD
	XOR A
	LD [rLCDC],A
	; do bullshit
	LD A,$00
.addtime:
	CALL time_add
	INC A
	CP A,$04
	JR Z,.addtime
	; turn on lcd
	LD A, LCDCF_ON | LCDCF_BGON | LCDCF_BG8000
	LD [rLCDC],A
	; wait
	CALL wait_vbl
	jr main_loop

