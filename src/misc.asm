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

copy_oam: ; copy shadow oam to oam
	LD BC,oam_shadow
	LD HL,_OAMRAM
	LD DE,OAMSIZE
	CALL memcpy
	RET

main_init:
	; enable interrupts
	EI
	LD A,IEF_VBLANK
	LD [rIE],A
	; reset stack
	LD SP,$FFFF
	; init & jump to mai
	CALL .init_sys
	CALL .init_gfx
	JP main_loop

.init_gfx:
	;CALL .init_pals
	CALL .init_fnt
	;CALL .init_mamigfx
	RET

.init_pals:
	; palette reset
	LD A,%11100100
	LD [rBGP],A
	LD [rOBP0],A
	LD [rOBP1],A
	; palette copy
	; ; copy emptypal
	LD DE,$0020 * 2 ; 32 colors
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
	; ; copy mamipal
	LD HL,palettes.mamipalN
	LD DE,$0004 * 2
	LD A,$04 ; 4th idex
	CALL palcpy_obj
	RET

.init_mamigfx:
	; copy char to vram
	LD BC,images.mamizou
	LD HL,_VRAM + $800 ; 128th tile
	LD DE,$10 * 4 ; 4 tiles
	CALL memcpy
	RET

.init_fnt:
	; copy char to vram
	LD BC,testfont
	LD HL,_VRAM
	LD DE,($10 * $80) ; 128 tiles
	CALL memcpy
	; copy text to vram
	LD BC,testtxt.txt1
	LD HL,_SCRN0
	CALL strcpy
	RET

.init_sys:
	; turn off LCD
	CALL wait_vbl
	XOR A
	LD [rLCDC],A
	; initialize misc memory
	CALL .init_ram
	RET
.init_ram:
	; WRAM clear
	LD HL,_RAM
	LD DE,$2000
	LD B,$7F
	CALL memset
	; OAM clear
	CALL copy_oam
	; VRAM clear
	LD HL,_VRAM
	LD DE,$2000
	LD B,$00
	CALL memset
	; VRAM bank 1 clear
	LD A,$1
	LD [rVBK],A ; use bank 1
	LD HL,_SCRN0
	LD DE,$800
	LD B,$00
	CALL memset
	LD A,$0
	LD [rVBK],A ; use bank 2
	RET

