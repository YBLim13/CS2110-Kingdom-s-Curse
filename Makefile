################################################################################
# These are variables for the GBA toolchain build
# You can add others if you wish to
# Youngho Lim
################################################################################

# TA-TODO: Put your game name here.
# The name of your desired application
# This should be a just a name i.e MyFirstGBAGame
# No SPACES AFTER THE NAME.
PROGNAME = Kingdom\'sCurseGame

# TA-TODO: Add the C files you want compiled here (replace extension with .o)
# Here you must put a list of all of the object files
# that will be compiled into your program. For example
# if you have main.c and myLib.c then in the following
# line you would put main.o and myLib.o
OFILES = gba.o font.o game.o images/Instructions.o images/Boss1AboutAttk.o images/Boss1Attacking.o images/Boss1NotAttk.o images/Boss2AboutAttk.o images/Boss2Attacking.o images/Boss2NotAttk.o images/Boss3AboutAttk.o images/Boss3Attacking.o images/Boss3NotAttk.o images/Boss4AboutAttk.o images/Boss4Attacking.o images/Boss4NotAttk.o images/DoorOverhead.o images/FloorCeiling.o images/Heart.o images/LeftAttacking.o images/LeftCrouching.o images/LeftLedge.o images/LeftMoving.o images/LeftPlatform.o images/Lose.o images/RightAttacking.o images/RightCrouching.o images/RightLedge.o images/RightMoving.o images/RightPlatform.o images/Title.o images/Wall.o images/Win.o

################################################################################
# These are various settings used to make the GBA toolchain work
# DO NOT EDIT BELOW.
################################################################################

.PHONY: all
all : CFLAGS += $(CRELEASE) -I../shared
all : LDFLAGS += $(LDRELEASE)
all: $(PROGNAME).gba
	@echo "[FINISH] Created $(PROGNAME).gba"

include /opt/cs2110-tools/GBAVariables.mak

# Son, it's time to be an adult and use adult prototypes
CFLAGS += -Wstrict-prototypes -Wold-style-definition

debug : CFLAGS += $(CDEBUG) -I../shared
debug : LDFLAGS += $(LDDEBUG)
debug : $(PROGNAME).gba
	@echo "[FINISH] Created $(PROGNAME).gba"

$(PROGNAME).gba : $(PROGNAME).elf
	@echo "[LINK] Linking objects together to create $(PROGNAME).gba"
	@$(OBJCOPY) -O binary $(PROGNAME).elf $(PROGNAME).gba

$(PROGNAME).elf : crt0.o $(GCCLIB)/crtbegin.o $(GCCLIB)/crtend.o $(GCCLIB)/crti.o $(GCCLIB)/crtn.o $(OFILES) libc_sbrk.o
	$(CC) -o $(PROGNAME).elf $^ $(LDFLAGS)

.PHONY : emu
emu : med

.PHONY : vba
vba : CFLAGS += $(CRELEASE) -I../shared
vba : LDFLAGS += $(LDRELEASE)
vba : $(PROGNAME).gba
	@echo "[EXECUTE] Running Emulator VBA-M"
	@echo "          Please see emulator.log if this fails"
	@vbam $(VBAOPT) $(PROGNAME).gba >emulator.log 2>&1

.PHONY : med
med : CFLAGS += $(CRELEASE) -I../shared
med : LDFLAGS += $(LDRELEASE)
med : $(PROGNAME).gba
	@echo "[EXECUTE] Running emulator Mednafen"
	@echo "          Please see emulator.log if this fails"
# Default mednafen keybinds are "Gaaarbage", in the words of Farzam
	@mkdir -p ~/.mednafen/
	@cp mednafen-09x.cfg ~/.mednafen/
	@mednafen $(MEDOPT) $(PROGNAME).gba >emulator.log 2>&1

.PHONY : submit
submit: clean
	@rm -f submission.tar.gz
	@tar czvf submission.tar.gz *

.PHONY : clean
clean :
	@echo "[CLEAN] Removing all compiled files"
	rm -f *.o *.elf *.gba *.log */*.o
