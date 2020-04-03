INCLUDE "hardware.inc"
INCLUDE "suwako.asm"

; entrypoint
SECTION "header",ROM0[$0100]
entrypoint:
	DI
	JP main_init

SECTION "vblank",ROM0[$0040]
int_vblank:
	RETI

; main code
SECTION "main",ROM0[$0150]
INCLUDE "kbase.asm"
INCLUDE "suwa_obj.asm"
INCLUDE "mami.asm"
INCLUDE "data.asm"
INCLUDE "misc.asm"

main_loop:
	; turn off LCD
	XOR A
	LD [rLCDC],A
	; update
	CALL mami_updt ; update game
	CALL time_add ; add 16-bit time
	; turn on lcd
	LD A, LCDCF_ON | LCDCF_BGON | LCDCF_BG8000
	LD [rLCDC],A
	; wait
	CALL wait_vbl
	jr main_loop

