TOOLS = ./tools
ASM = $(TOOLS)/rgbasm
LNK = $(TOOLS)/rgblink
FIX = $(TOOLS)/rgbfix

NAME = build/mami.gb

all:
	$(ASM) -o mami.o main.asm
	$(LNK) -o $(NAME) mami.o
	$(FIX) -v -p 0 $(NAME)

