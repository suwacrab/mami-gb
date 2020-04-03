INCLUDE "src/hardware.inc"
INCLUDE "src/suwako.asm"

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
INCLUDE "src/data.asm"
INCLUDE "src/kbase.asm"
INCLUDE "src/suwa_obj.asm"
INCLUDE "src/mami.asm"
INCLUDE "src/misc.asm"

main_loop:
	; turn off LCD
	XOR A
	LD [rLCDC],A
	; update
	CALL mami_updt ; update game
	CALL time_add ; add 16-bit time
	; turn on lcd
	LD A, LCDCF_ON | LCDCF_BGON | LCDCF_BG8000 | LCDCF_OBJON
	; wait
	CALL wait_vbl
	jr main_loop

