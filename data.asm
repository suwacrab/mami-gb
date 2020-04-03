testtxt:
	DW .txt0
	DW .txt1
.txt0: DB "oh! create!",0
.txt1: DB "ah? remove?",0
palettes:
	.testpal0: INCBIN "pals/testpal0.bin"
	.creampal: INCBIN "pals/creampal.bin"
	.emptypal: INCBIN "pals/emptypal.bin"
images:
	.mamizou: INCBIN "gfx/mamizou.bin"
testfont:
	INCBIN "gfx/font.chr"
testfont_end:
