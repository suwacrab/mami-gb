TOOLS = ./tools
ASM = $(TOOLS)/rgbasm
LNK = $(TOOLS)/rgblink
FIX = $(TOOLS)/rgbfix

OBJ = mami.o
NAME = build/mami.gb

all:
	$(ASM) -o $(OBJ) main.asm
	$(LNK) -o $(NAME) $(OBJ)
	$(FIX) -v -p 0 $(NAME)

clean:
	rm $(OBJ)
