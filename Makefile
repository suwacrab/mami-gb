TOOLS = ./tools
ASM = $(TOOLS)/rgbasm
LNK = $(TOOLS)/rgblink
FIX = $(TOOLS)/rgbfix

# flags
GBNAME = -t MAMIZOU
FIXFLAG := $(GBNAME)
FIXFLAG += -C -v -p 0
# symbols
SYMNAME = build/mami.sym

OBJ = mami.o
NAME = build/mami.gbc

all:
	$(ASM) -E -o $(OBJ) src/main.asm
	$(LNK) -n $(SYMNAME) -o $(NAME) $(OBJ)
	$(FIX) $(FIXFLAG) $(NAME)

clean:
	rm $(OBJ)
