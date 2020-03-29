INCLUDE "hardware.inc"
INCLUDE "suwako.asm"

; entrypoint
SECTION "header",ROM0[$0100]
entrypoint:
	DI
	JP start

SECTION "main",ROM0[$0150]
start:
	CALL .init_sys
	jp main_loop

.init_sys:
	; turn off LCD
	LD A,[rLY]
	CP 144
	JR C,.init_sys
	; palette reset
	LD A,%11100100
	LD [rBGP],A

.init_
	
	RET

main_loop:
	jr main_loop
